using AdminService as service from '../../srv/admin-service';

annotate service.Books with @(
    UI.HeaderInfo                  : {
        TypeName: 'Books',
        Title   : {Value: title}
    },
    UI.Facets                      : [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'InventoryFacet',
            Label : 'Stock & Pricing',
            Target: '@UI.FieldGroup#InventoryMetrics'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'SystemFacet',
            Label : 'System Identifies',
            Target: '@UI.FieldGroup#TechnicalData'
        }
    ],
    UI.FieldGroup #InventoryMetrics: {Data: [
        {
            $Type: 'UI.DataField',
            Value: stock,
            Label: 'Current Warehouse Stock'
        },
        {
            $Type: 'UI.DataField',
            Value: price,
            Label: 'Retail Price (USD)'
        }
    ]},
    UI.FieldGroup #TechnicalData   : {Data: [
        {
            $Type: 'UI.DataField',
            Value: ID,
            Label: 'Internal ID'
        },
        {
            $Type: 'UI.DataField',
            Value: author_ID,
            Label: 'Assigned author reference ID'
        }
    ]},
    UI.SelectionFields             : [
        title,
        stock
    ],
    UI.LineItem                    : [
        {
            $Type: 'UI.DataField',
            Value: title,
            Label: 'Book Title'
        },
        {
            $Type: 'UI.DataField',
            Value: stock,
            Label: 'Available Stock'
        },
        {
            $Type: 'UI.DataField',
            Value: price,
            Label: 'Price (USD)'
        }
    ]
);
