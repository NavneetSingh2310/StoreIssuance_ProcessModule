page 50143 "Requester Details Factbox"
{
    Caption = 'Requester Details';
    PageType = CardPart;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Purchase Requisition";

    layout
    {
        area(Content)
        {
            group("")
            {
                field("Document No."; "Document No.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("User ID"; "User Id")
                {
                    ApplicationArea = All;



                }
                field("Requestor Name"; "Requestor Name") { ApplicationArea = All; }
                field("Total Requests"; "Total Requests") { ApplicationArea = All; }
            }
        }

    }

    trigger OnAfterGetCurrRecord()
    var
        PurchaseRec: Record "Purchase Requisition";
    begin
        PurchaseRec.SetRange("User Id", "User Id");
        PurchaseRec.FindSet();
        "Total Requests" := PurchaseRec.Count;
    end;

}