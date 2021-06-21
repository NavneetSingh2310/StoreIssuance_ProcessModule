page 50145 "PR Lines Factbox"
{
    Caption = 'PR Lines Factbox';
    PageType = CardPart;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = Item;

    layout
    {
        area(Content)
        {
            group(Group)
            {
                field("Item No."; "No.") { ApplicationArea = All; Editable = false; }
                field("Available In Inventory"; Inventory) { ApplicationArea = All; Editable = false; }

            }
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
}