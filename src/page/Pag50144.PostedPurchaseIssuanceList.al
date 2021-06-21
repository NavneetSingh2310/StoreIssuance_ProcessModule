page 50144 "Posted Purchase Issuance List"
{
    Caption = 'Posted Purchase Issuance List';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Purchase Requisition";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("PPR No."; "PPR No.") { ApplicationArea = All; }
                field("Purchase Req. No."; "Document No.") { ApplicationArea = All; }
                field("Document Type."; "Document Type.") { ApplicationArea = All; }
                field("Document Date"; "Document Date") { ApplicationArea = All; }
                field("Release Date"; "Release Date") { ApplicationArea = All; }
                field("Location Code"; "Location Code") { ApplicationArea = All; }


            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Issuance List")
            {
                ApplicationArea = All;
                Image = Report;
                Promoted = true;

                trigger OnAction();
                var
                    report1: Report "Issuance Report";
                    PR: Record "Purchase Requisition";
                begin
                    PR.SetRange("Document No.", "Document No.");
                    if PR.FindSet() then begin
                        report1.SetTableView(PR);
                        report1.Run();
                    end;

                end;
            }
        }
        area(Navigation)
        {
            action("Navigate")
            {
                Image = Navigate;
                ApplicationArea = All;
                Promoted = true;
                trigger OnAction()
                var
                    documentEntry: Record "Document Entry" temporary;
                    page1: page Navigate;
                begin
                    page1.SetDoc("Posting Date", "Document No.");
                    page1.SetRec(documentEntry);
                    page1.Run();
                end;
            }
        }

    }


    trigger OnOpenPage()
    begin
        SetRange(status, status::Released);
        SetRange("Store issuance Posted", true);
        FindSet();
    end;
}