class AnimalsRequest {
  int page;
  int limit;

  AnimalsRequest({
    this.page = 0,
    this.limit = 60
  });

  Map<String, dynamic> toJson() => {
    "offset": page * limit,
    "limit": limit
  };
}