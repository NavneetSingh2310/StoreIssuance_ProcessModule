codeunit 50140 "SI Codeunit"
{
    SingleInstance = true;
    procedure PostEntries(DocNo: Code[20])
    var
        GLEntry: Record "G/L Entry";
        VLEntry: Record "Value Entry";
        ILEntry: Record "Item Ledger Entry";
        documentEntry: Record "Document Entry";
        SILines: Record "PR Resources";
        PR: Record "Purchase Requisition";
    begin
        PR.Get(DocNo);
        SILines.SetRange(ID, DocNo);
        if SILines.FindSet() then begin
            repeat
                GLEntry."Entry No." := GLEntry.GetLastEntryNo() + 1;
                GLEntry."Document No." := DocNo;
                GLEntry."Posting Date" := Today;
                GLEntry."Document Date" := PR."Document Date";
                GLEntry."G/L Account No." := '54710';
                GLEntry.Amount := SILines."Total Amount";
                GLEntry.Description := Format('Store Issuance For item ' + SILines.Description);
                GLEntry.Insert();
                GLEntry."Entry No." := GLEntry.GetLastEntryNo() + 1;
                GLEntry."Document No." := DocNo;
                GLEntry."Posting Date" := Today;
                GLEntry."Document Date" := PR."Document Date";
                GLEntry."G/L Account No." := '54710';
                GLEntry.Amount := -SILines."Total Amount";
                GLEntry.Description := Format('Store Issuance For item ' + SILines.Description);
                GLEntry.Insert();


                VLEntry."Document Date" := PR."Document Date";
                VLEntry."Posting Date" := Today;
                VLEntry."Entry Type" := VLEntry."Entry Type"::"Direct Cost";
                VLEntry."Cost per Unit" := SILines."Direct Unit Cost Excl. VAT ";
                VLEntry."Item Ledger Entry Type" := VLEntry."Item Ledger Entry Type"::Purchase;
                VLEntry.Description := Format('Store Issuance For item ' + SILines.Description);
                VLEntry."Item Ledger Entry Quantity" := SILines."Quantity Issued";
                VLEntry."Entry No." := VLEntry.GetLastEntryNo() + 1;
                VLEntry."Document No." := DocNo;
                VLEntry."Cost Amount (Expected)" := SILines."Direct Unit Cost Excl. VAT " * SILines."Quantity Issued";
                VLEntry."Cost Amount (Actual)" := SILines."Total Amount";
                VLEntry.Insert();


                ILEntry."Document Date" := PR."Document Date";
                ILEntry."Posting Date" := Today;
                ILEntry."Entry Type" := VLEntry."Entry Type"::"Direct Cost";
                ILEntry."Cost Amount (Actual)" := SILines."Direct Unit Cost Excl. VAT ";
                ILEntry."Item No." := SILines."Item No.";
                ILEntry.Description := Format('Store Issuance For item ' + SILines.Description);
                ILEntry."Entry Type" := ILEntry."Entry Type"::"Positive Adjmt.";
                ILEntry.Quantity := SILines."Quantity Issued";
                ILEntry."Entry No." := ILEntry.GetLastEntryNo() + 1;
                ILEntry."Document No." := DocNo;
                ILEntry."Location Code" := SILines."Location Code";
                ILEntry."Cost Amount (Expected)" := SILines."Direct Unit Cost Excl. VAT " * SILines."Quantity Issued";
                ILEntry."Cost Amount (Actual)" := SILines."Total Amount";
                ILEntry.Insert();

            until SILines.Next() = 0;
        end;

    end;

    procedure setItemNo(no: Code[30])
    begin
        currentItemNo := no;
    end;

    procedure getItemNo(): Code[30]
    begin
        exit(currentItemNo);
    end;

    procedure Post("Document No.": Code[20])
    var
        Lines: Record "PR Resources";
        total_Lines_posted: Integer;
        PostYesNo: Boolean;
        total_remaining_to_post: Integer;
        PR: Record "Purchase Requisition";
        code_unit: Codeunit "SI Codeunit";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CurrentSeries: Code[15];
        Series: Record "No. Series";
    begin
        total_Lines_posted := 0;
        total_remaining_to_post := 0;
        PostYesNo := Confirm('Do you want to post the issuance document?');
        if PostYesNo = true then begin
            Lines.SetRange(ID, "Document No.");
            if Lines.FindSet() then begin
                repeat
                    if Lines."Quantity to issue" > 0 then begin
                        total_Lines_posted := total_Lines_posted + 1;
                        Lines."Quantity Issued" := Lines."Quantity to issue";
                        Lines."Outstanding Quantity" := Lines."Outstanding Quantity" - Lines."Quantity to issue";
                        Lines."Quantity to issue" := 0;
                    end;
                    if Lines."Quantity to Cancel" > 0 then begin
                        total_Lines_posted := total_Lines_posted + 1;
                        Lines."Outstanding Quantity" := Lines."Outstanding Quantity" - Lines."Quantity to Cancel";
                        Lines."Quantity to Cancel" := 0;
                    end;
                    Lines.Modify();
                until Lines.Next() = 0;
            end;

            if total_Lines_posted = 0 then
                Error('Nothing to post')
            else begin
                Message('Posted');
                Clear(Lines);
                Lines.SetRange(ID, "Document No.");
                if Lines.FindSet() then begin
                    repeat
                        if Lines."Outstanding Quantity" <> 0 then
                            total_remaining_to_post := total_remaining_to_post + 1;
                    until Lines.Next() = 0;
                end;
                if total_remaining_to_post = 0 then begin
                    PR.SetRange("Document No.", "Document No.");
                    if PR.FindSet() then begin
                        PR."Store issuance Posted" := true;
                        PR."PPR No." := 'PPR-NO';
                        CurrentSeries := PR."PPR No.";
                        Series.Get(CurrentSeries);
                        PR."PPR No." := NoSeriesMgt.GetNextNo(PR."PPR No.", 0D, true);
                        PR.Modify();
                        code_unit.PostEntries("Document No.");
                    end;
                end;

            end;
        end;
    end;

    var
        currentItemNo: Code[30];
}