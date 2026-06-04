using {CatalogueService} from './cat-service';


annotate CatalogueService.Reviews with {
    names   @mandatory;
    comment @mandatory;
    rating  @assert.range: [
        1,
        5
    ];
}
