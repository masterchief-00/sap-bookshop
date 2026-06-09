using {sap.capire.bookshop as my} from '../db/schema';

service AdminService @(odata: '/admin') {
    @odata.draft.enabled
    entity Authors as projection on my.Authors;

    @odata.draft.enabled
    entity Books   as projection on my.Books;

    @odata.draft.enabled
    entity Genres  as projection on my.Genres;

    @odata.draft.enabled
    entity Orders  as projection on my.Orders;

    @odata.draft.enabled
    entity Logs    as projection on my.Logs;

    function getStockLogs() returns array of Logs;
}

event LowStockAlert {
    book_ID      : Integer;
    title        : String;
    currentStock : Integer;
}
