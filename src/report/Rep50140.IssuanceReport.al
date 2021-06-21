report 50140 "Issuance Report"
{
    Caption = 'Issuance List';
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = '.\SuppliesIssuance.rdl';


    dataset
    {
        dataitem(PurchR; "Purchase Requisition")
        {
            column("CompanyName"; CompanyName) { }
            column("DocumentNo"; "Document No.") { }
            column("DocumentType"; "Document Type.") { }
            column("RequestorName"; "Requestor Name") { }
            column("RequestFor"; "Request For") { }
            column("DepartmentName"; "Department Name") { }
            column(Remarks; Remarks) { }
            column(status; status) { }
            column("DocumentDate"; "Document Date") { }
            column("ReleaseDate"; "Release Date") { }
            column("LocationCode"; "Location Code") { }
            dataitem(PR; "PR Resources")
            {
                DataItemLink = ID = field("Document No.");
                column(Type; Type) { }
                column("ItemNo"; "Item No.") { }
                column("UnitofMeasure"; "Unit of Measure") { }
                column(Description; Description) { }
                column(Description2; Description2) { }
                column("RequestedQunatity"; "Requested Qunatity") { }
                column("Quantitytoissue"; "Quantity to issue")
                {
                }
                column("OutstandingQuantity"; "Outstanding Quantity") { }
                column("QuantityIssued"; "Quantity Issued") { }
                column("QuantitytoCancel"; "Quantity to Cancel")
                {
                }
            }
        }

    }
}