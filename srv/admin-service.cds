using {sap.capire.bookshop as my} from '../db/schema';

service AdminService @(odata: '/admin') {
    entity Authors as projection on my.Authors;
    entity Books   as projection on my.Books;
    entity Genres  as projection on my.Genres;
    entity Orders  as projection on my.Orders;
    entity Logs    as projection on my.Logs;

    function getStockLogs() returns array of Logs;
}

event LowStockAlert {
    book_ID      : Integer;
    title        : String;
    currentStock : Integer;
}
