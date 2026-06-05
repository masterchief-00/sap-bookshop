sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"ns/books/test/integration/pages/BooksList",
	"ns/books/test/integration/pages/BooksObjectPage",
	"ns/books/test/integration/pages/Books_reviewsObjectPage"
], function (JourneyRunner, BooksList, BooksObjectPage, Books_reviewsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('ns/books') + '/test/flp.html#app-preview',
        pages: {
			onTheBooksList: BooksList,
			onTheBooksObjectPage: BooksObjectPage,
			onTheBooks_reviewsObjectPage: Books_reviewsObjectPage
        },
        async: true
    });

    return runner;
});

