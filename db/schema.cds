using {
    Currency,
    managed,
    sap
} from '@sap/cds/common';

namespace sap.capire.bookshop;

entity Books : managed {
    key ID       : UUID;
        title    : localized String;
        descr    : localized String;
        author   : Association to Authors;
        genre    : Association to Genres;
        stock    : Integer;
        price    : Decimal;
        currency : Currency;
        reviews  : Composition of many Reviews
}

entity Authors : managed {
    key ID    : UUID;
        name  : String;
        books : Association to many Books
                    on books.author = $self;
}

entity Genres : sap.common.CodeList {
    key ID     : Integer;
        parent : Association to Genres;
}

entity Orders : managed {
    key ID     : UUID;
        name   : String;
        amount : Integer;
        book   : Association to Books;
}

aspect Reviews : managed {
    key ID      : UUID;
        names   : String;
        rating  : Decimal;
        comment : String;
}

entity Logs {
    key ID            : UUID;
        createdAt     : Timestamp @cds.on.insert: $now; // Automatically timestamps the log
        bookTitle     : String;
        recordedStock : Integer;
        triggeredBy   : String;
}
