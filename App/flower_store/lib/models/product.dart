class Product {
  final String name;
  double price;
  final String imageUrl;
  bool isFavorite;
  String? description;
  late int stock;
  late List<Product> includeProducts;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.isFavorite,
    int? stock,
    this.description,
    List<Product>? includeProducts
  }) {
    this.stock = stock ?? 1;
    this.includeProducts = includeProducts ?? [];
  }

  static List<Product> products = [
    Product(
      name: 'Blushing Bride',
      price: 56,
      imageUrl:
          'https://product.hstatic.net/200000846175/product/z5544206552217_68cd21965416a9e4e15d838797fafb68-min_047147ebaacc456095f669d928b2052b_1024x1024.jpg',
      isFavorite: true,
      stock: 10,
      description: "Lorem ipsum dolor sit amet consectetur. Et aliquam orci pellentesque viverra faucibus sed diam magna. Aliquet velit turpis gravida ipsum massa mauris Lorem ipsum dolor sit amet consectetur. Et aliquam orci pellentesque viverra faucibus sed diam magna. Aliquet velit turpis gravida ipsum massa mauris Lorem ipsum dolor sit amet consectetur. Et aliquam orci pellentesque viverra faucibus sed diam magna. Aliquet velit turpis gravida ipsum massa mauris Lorem ipsum dolor sit amet consectetur. Et aliquam orci pellentesque viverra faucibus sed diam magna. Aliquet velit turpis gravida ipsum massa mauris Lorem ipsum dolor sit amet consectetur. Et aliquam orci pellentesque viverra faucibus sed diam magna. Aliquet velit turpis gravida ipsum massa mauris Lorem ipsum dolor sit amet consectetur. Et aliquam orci pellentesque viverra faucibus sed diam magna. Aliquet velit turpis gravida ipsum massa mauris",
      includeProducts: [
        Product(
          name: 'Orange tulips', 
          price: 6, 
          imageUrl: 'https://labellarosaflowers.com/cdn/shop/products/B734817C-DE8A-4244-8F9A-76EDEC4136B62.jpg?v=1641203935&width=2200', 
          isFavorite: false
        ),
        Product(
          name: 'Pink roses', 
          price: 9, 
          imageUrl: 'https://labellarosaflowers.com/cdn/shop/products/FullSizeRender156.jpg?v=1645196351&width=2200', 
          isFavorite: false
        ),
        Product(
          name: 'White daisies', 
          price: 7.5, 
          imageUrl: 'https://product.hstatic.net/200000846175/product/z5585714112334_bcd9c83928e16e7b1f93006df9500d94-min__1__0938be19940c46b5a261fcf29ffd2a62_1024x1024.jpg', 
          isFavorite: false
        ),
        Product(
          name: 'Light pink lisianthus', 
          price: 6.8, 
          imageUrl: 'https://product.hstatic.net/200000846175/product/z5585714112334_bcd9c83928e16e7b1f93006df9500d94-min__1__0938be19940c46b5a261fcf29ffd2a62_1024x1024.jpg', 
          isFavorite: false
        ),
      ]
    ),
    Product(
      name: 'Herves Love',
      price: 56,
      imageUrl:
          'https://product.hstatic.net/200000846175/product/_052e215d0bf4937c855e88d6d4b3e092-min_4ee2c7cf7ae24d67b1b46156d8b96f8c_bd89a4bf469c4db7833f9c3a51f8252e_1024x1024.jpg',
      isFavorite: true,
      stock: 10,
      description: "Lorem ipsum dolor sit amet consectetur. Et aliquam orci pellentesque viverra faucibus sed diam magna. Aliquet velit turpis gravida ipsum massa mauris"
    ),
    Product(
      name: 'Rose Bouquet',
      price: 56,
      imageUrl:
          'https://product.hstatic.net/200000846175/product/4-min_d37e9a752bc145a4b6c407f01666a7d4_f60c9f31b2f947f285846b25733d2dc4_1024x1024.jpg',
      isFavorite: true,
      stock: 10,
      description: "Lorem ipsum dolor sit amet consectetur. Et aliquam orci pellentesque viverra faucibus sed diam magna. Aliquet velit turpis gravida ipsum massa mauris"
    ),
    Product(
      name: 'Blushing Bride',
      price: 56,
      imageUrl:
          'https://product.hstatic.net/200000846175/product/z5544206552217_68cd21965416a9e4e15d838797fafb68-min_047147ebaacc456095f669d928b2052b_1024x1024.jpg',
      isFavorite: true,
      stock: 10,
      description: "Lorem ipsum dolor sit amet consectetur. Et aliquam orci pellentesque viverra faucibus sed diam magna. Aliquet velit turpis gravida ipsum massa mauris"
    ),
    Product(
      name: 'Herves Love',
      price: 56,
      imageUrl:
          'https://product.hstatic.net/200000846175/product/_052e215d0bf4937c855e88d6d4b3e092-min_4ee2c7cf7ae24d67b1b46156d8b96f8c_bd89a4bf469c4db7833f9c3a51f8252e_1024x1024.jpg',
      isFavorite: true,
    ),
    Product(
      name: 'Rose Bouquet',
      price: 56,
      imageUrl:
          'https://product.hstatic.net/200000846175/product/4-min_d37e9a752bc145a4b6c407f01666a7d4_f60c9f31b2f947f285846b25733d2dc4_1024x1024.jpg',
      isFavorite: true,
    ),
    Product(
      name: 'Blushing Bride',
      price: 56,
      imageUrl:
          'https://product.hstatic.net/200000846175/product/z5544206552217_68cd21965416a9e4e15d838797fafb68-min_047147ebaacc456095f669d928b2052b_1024x1024.jpg',
      isFavorite: true,
    ),
    Product(
      name: 'Herves Love',
      price: 56,
      imageUrl:
          'https://product.hstatic.net/200000846175/product/_052e215d0bf4937c855e88d6d4b3e092-min_4ee2c7cf7ae24d67b1b46156d8b96f8c_bd89a4bf469c4db7833f9c3a51f8252e_1024x1024.jpg',
      isFavorite: true,
    ),
    Product(
      name: 'Rose Bouquet',
      price: 56,
      imageUrl:
          'https://product.hstatic.net/200000846175/product/4-min_d37e9a752bc145a4b6c407f01666a7d4_f60c9f31b2f947f285846b25733d2dc4_1024x1024.jpg',
      isFavorite: true,
    ),
  ];
}
