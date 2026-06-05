using AdminService from '../../srv/admin-service';

annotate AdminService.Logs with @(
    UI.LineItem       : [
        {
            Value: createdAt,
            Label: 'Timestamp'
        },
        {
            Value: bookTitle,
            Label: 'Book Title'
        },
        {
            Value: recordedStock,
            Label: 'Stock Level'
        },
        {
            Value: triggeredBy,
            Label: 'Source'
        }
    ],
    UI.HeaderInfo     : [{
        TypeName      : 'Inventory Log',
        TypeNamePlural: 'Inventory Logs',
        Title         : {Value: bookTitle}
    }],
    UI.SelectionFields: [
        bookTitle,
        triggeredBy
    ]
)
