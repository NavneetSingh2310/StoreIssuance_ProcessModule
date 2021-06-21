page 50140 "Store Issuance List"
{
    Caption = 'Store Issuance List';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Purchase Requisition";
    CardPageId = "Store Issuance Card";
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document No."; "Document No.") { ApplicationArea = All; }
                field("Document Type."; "Document Type.") { ApplicationArea = All; }
                field("Document Date"; "Document Date") { ApplicationArea = All; }
                field("Release Date"; "Release Date") { ApplicationArea = All; }
                field("Location Code"; "Location Code") { ApplicationArea = All; }
                field("Requestor Name"; "Requestor Name") { ApplicationArea = All; }
                field("Department Name"; "Department Name") { ApplicationArea = All; }
                field(status; status) { ApplicationArea = All; }

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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        SetRange(status, status::Released);
        SetRange("Store issuance Posted", false);
    end;
}