using {AdminService} from './admin-service';

annotate AdminService.Books with {
    title  @mandatory;
    author @assert      : (case
                               when not exists author
                                    then 'Specified Author does not exist'
                           end);
    genre  @mandatory  @assert: (case
                                     when not exists genre
                                          then 'Specified Genre does not exit'
                                 end);
    price  @assert.range: [
        1,
        111
    ];
    stock  @assert.range: [
        (0),
        _
    ]
}

annotate AdminService.Orders with {
    name   @mandatory  @assert.format: '^[A-Za-z. ]';

    book   @mandatory;

    amount @assert.range: [
        (0),
        _
    ]
}
