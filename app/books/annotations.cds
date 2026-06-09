using AdminService as service from '../../srv/admin-service';
using from '../../db/schema';


annotate service.Books with @(
    UI.HeaderInfo                              : {
        TypeName: 'Books',
        Title   : {Value: title}
    },
    UI.Facets                                  : [
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
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General Info',
            ID    : 'GeneralInfoSection',
            Target: '@UI.FieldGroup#GeneralInfoSection',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Genre',
            ID    : 'Genre',
            Target: '@UI.FieldGroup#Genre',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Reviews',
            ID    : 'Reviews',
            Target: 'reviews/@UI.LineItem#Reviews',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'ReviewsChartSection',
            Label : 'Ratings Distribution',
            Target: 'reviews/@UI.Chart#DefaultChart'
        }
    ],
    UI.FieldGroup #InventoryMetrics            : {Data: [
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
    UI.FieldGroup #TechnicalData               : {Data: [{
        $Type: 'UI.DataField',
        Value: author_ID,
        Label: 'Assigned author reference ID'
    }]},
    UI.SelectionFields                         : [
        title,
        stock
    ],
    UI.LineItem                                : [
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
    ],
    UI.SelectionPresentationVariant #tableView : {
        $Type              : 'UI.SelectionPresentationVariantType',
        PresentationVariant: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.LineItem',
            ],
        },
        SelectionVariant   : {
            $Type        : 'UI.SelectionVariantType',
            SelectOptions: [],
        },
        Text               : 'Table View',
    },
    UI.SelectionPresentationVariant #tableView1: {
        $Type              : 'UI.SelectionPresentationVariantType',
        PresentationVariant: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.LineItem#tableView',
            ],
        },
        SelectionVariant   : {
            $Type        : 'UI.SelectionVariantType',
            SelectOptions: [],
        },
        Text               : 'Table View 1',
    },
    UI.SelectionPresentationVariant #tableView2: {
        $Type              : 'UI.SelectionPresentationVariantType',
        PresentationVariant: {
            $Type         : 'UI.PresentationVariantType',
            Visualizations: ['@UI.LineItem#tableView1',
            ],
        },
        SelectionVariant   : {
            $Type        : 'UI.SelectionVariantType',
            SelectOptions: [],
        },
        Text               : 'Table View 2',
    },
    UI.FieldGroup #Extra                       : {
        $Type: 'UI.FieldGroupType',
        Data : [],
    },
    UI.FieldGroup #GeneralInfoSection          : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: currency_code,
            },
            {
                $Type: 'UI.DataField',
                Value: descr,
                Label: 'descr',
            },
            {
                $Type: 'UI.DataField',
                Value: title,
                Label: 'title',
            },
        ],
    },
    UI.FieldGroup #reviewing                   : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: reviews.comment,
                Label: 'comment',
            },
            {
                $Type: 'UI.DataField',
                Value: reviews.names,
                Label: 'names',
            },
            {
                $Type: 'UI.DataField',
                Value: reviews.rating,
                Label: 'rating',
            },
        ],
    },
    UI.FieldGroup #Genre                       : {
        $Type: 'UI.FieldGroupType',
        Data : [{
            $Type: 'UI.DataField',
            Value: genre_ID,
            Label: 'genre_ID',
        }, ],
    },
    UI.PresentationVariant:{
        MaxItems:20,
        Visualizations:['@UI.LineItem']
    }
);

annotate service.Books with {
    author @(
        Common.ExternalID              : author.name,
        Common.ValueList               : {
            $Type         : 'Common.ValueListType',
            CollectionPath: 'Authors',
            Parameters    : [{
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: author_ID,
                ValueListProperty: 'ID',
            }, ],
            Label         : 'Show authors',
        },
        Common.ValueListWithFixedValues: true,
    )
};

annotate service.Books.reviews with @(
    Aggregation.ApplySupported                     : {
        Transformations       : [
            'aggregate',
            'groupby'
        ],
        Rollup                : #None,
        GroupableProperties   : [rating],
        AggregatableProperties: [{
            Property                   : ID,
            SupportedAggregationMethods: ['countdistinct']
        }]
    },
    UI.LineItem #Reviews                           : [
        {
            $Type: 'UI.DataField',
            Value: comment,
            Label: '{i18n>commentLabel}',
        },
        {
            $Type: 'UI.DataField',
            Value: names,
            Label: '{i18n>reviewerNameLabel}',
        },
        {
            $Type: 'UI.DataField',
            Value: rating,
            Label: '{i18n>ratingLabel}',
        },
    ],
    Analytics.AggregatedProperty #RatingCalculation: {
        $Type               : 'Analytics.AggregatedPropertyType',
        Name                : 'RatingCalculation',
        AggregatableProperty: ID,
        AggregationMethod   : 'countdistinct',
        @Common.Label       : '{i18n>numberOfReviewsLabel}',
    },
    UI.Chart #DefaultChart                         : {
        $Type              : 'UI.ChartDefinitionType',
        Description        : '{i18n>chartDescription}',
        Title              : '{i18n>ratingsOverview}',
        ChartType          : #Bar,
        Dimensions         : [rating, ],
        DimensionAttributes: [{
            $Type    : 'UI.ChartDimensionAttributeType',
            Dimension: rating,
            Role     : #Category,
        }, ],
        DynamicMeasures    : ['@Analytics.AggregatedProperty#RatingCalculation',
        ],
        MeasureAttributes  : [
            {
                $Type         : 'UI.ChartMeasureAttributeType',
                DynamicMeasure: '@Analytics.AggregatedProperty#RatingCalculation',
                Role          : #Axis1,
            },
            {
                $Type         : 'UI.ChartMeasureAttributeType',
                DynamicMeasure: '',
                Role          : #Axis1,
            },
        ],
    },
    UI.Facets                                      : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.Chart#DefaultChart',
        Label : 'Rating Distribution',
        ID    : 'ReviewsChartSection',
    }, ],
);
