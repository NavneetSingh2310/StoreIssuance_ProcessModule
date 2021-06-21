page 50141 "Store Issuance Card"
{
    Caption = 'Released Purchase Request';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Purchase Requisition";


    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Document No."; "Document No.") { ApplicationArea = All; Editable = false; }
                field("Document Type."; "Document Type.") { ApplicationArea = All; Editable = false; }
                field("Requestor Name"; "Requestor Name") { ApplicationArea = All; Editable = false; }
                field("Request For"; "Request For") { ApplicationArea = All; Editable = false; }
                field("Department Name"; "Department Name") { ApplicationArea = All; Editable = false; }
                field(Remarks; Remarks) { ApplicationArea = All; }
                field(status; status) { ApplicationArea = All; Editable = false; }
                field("Document Date"; "Document Date") { ApplicationArea = All; Editable = false; }
                field("Release Date"; "Release Date") { ApplicationArea = All; Editable = false; }
                field("Location Code"; "Location Code") { ApplicationArea = All; Editable = false; }
                field(currentItemNo; currentItemNo) { ApplicationArea = All; Visible = false; }
            }
            part("Item issuance"; "Store Issuance Lines")
            {
                ApplicationArea = all;
                SubPageLink = ID = field("Document No.");
            }
        }
        area(Factboxes)
        {
            part("Requester Details"; "Requester Details Factbox")
            {
                SubPageLink = "Document No." = field("Document No.");
                ApplicationArea = All;
            }
            part("PR Lines Factbox"; "PR Lines Factbox")
            {
                Provider = "Item issuance";
                SubPageLink = "No." = field("Item No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action("Post")
            {
                ApplicationArea = All;
                Image = Post;
                trigger OnAction()
                begin
                    code_unit.Post("Document No.");
                end;





            }

        }
    }

    var
        code_unit: Codeunit "SI Codeunit";
        currentItemNo: Code[30];

}