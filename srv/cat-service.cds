using {sap.capire.bookshop as my} from '../db/schema';

service CatalogueService @(odata: '/browse') {
  @readonly
  @odata.page.size: 20
  entity Books   as
    projection on my.Books {
      *,
      author.name as author,
      genre.name  as genre,
    }
    excluding {
      createdBy,
      modifiedBy
    };

  entity Reviews as projection on my.Books.reviews;

  action submitOrder(bookId: Integer, quantity: Integer, name: String) returns String;
}
