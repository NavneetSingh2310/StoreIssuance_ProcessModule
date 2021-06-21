page 50142 "Store Issuance Lines"
{
    Caption = 'Item Issuance';
    PageType = ListPart;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "PR Resources";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Type; Type) { ApplicationArea = all; Editable = false; }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("Unit of Measure"; "Unit of Measure") { ApplicationArea = all; Editable = false; }
                field(Description; Description) { ApplicationArea = all; Editable = false; }
                field(Description2; Description2) { ApplicationArea = all; Editable = false; }
                field("Requested Qunatity"; "Requested Qunatity") { ApplicationArea = all; Editable = false; }
                field("Quantity to issue"; "Quantity to issue")
                {

                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        if "Quantity to issue" > "Outstanding Quantity" then
                            Error('Quantity to issue should be less that Oustanding Quantity');
                    end;
                }
                field("Outstanding Quantity"; "Outstanding Quantity") { ApplicationArea = all; Editable = false; }
                field("Quantity Issued"; "Quantity Issued") { ApplicationArea = all; Editable = false; }
                field("Quantity to Cancel"; "Quantity to Cancel")
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        if "Quantity to Cancel" > "Outstanding Quantity" then
                            Error('Quantity to cancel should be less that Oustanding Quantity');
                    end;
                }




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