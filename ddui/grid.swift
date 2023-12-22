import SwiftUI

struct MyUIModel: Decodable {
    let screen: MyScreen
    let components: [MyUIComponent]
}

struct MyScreen: Decodable {
    let title: String
    let backgroundColor: String
}

struct MyUIComponent: Decodable, Identifiable {
    let type: String
    let id: String
    let columns: Int?
    let rows: Int?
    let items: [MyImageData]?
    let include: Bool
    let backgroundColor: String?
}

struct MyImageData: Decodable, Identifiable {
    let id: String
    let url: String
}

struct MyImageGridView: View {
    let component: MyUIComponent

    var body: some View {
        if component.include {
            let columns = component.columns ?? 2
            let rows = component.rows ?? 2
            let gridItems = Array(component.items?.prefix(rows * columns) ?? [])

            LazyVGrid(columns: Array(repeating: GridItem(), count: columns)) {
                ForEach(gridItems) { item in
                    MyImageView(url: item.url)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(hex: component.backgroundColor ?? ""))
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, 8.0)
                }
            }
            .padding(.horizontal, 8.0)
        } else {
            EmptyView()
        }
    }
}

struct MyImageView: View {
    let url: String

    var body: some View {
        if let imageUrl = URL(string: url),
           let imageData = try? Data(contentsOf: imageUrl),
           let uiImage = UIImage(data: imageData) {
            Image(uiImage: uiImage)
                .resizable()
                .frame(width: 150, height: 150)
                .cornerRadius(10)
        }
    }
}

struct MycView: View {
    let jsonData = """
        {
          "screen": {
            "title": "Image Grid Screen",
            "backgroundColor": "#FF0000"
          },
          "components": [
            {
              "type": "grid",
              "id": "gridImages",
              "columns": 2,
              "rows": 3,
              "items": [
                {"id": "image1", "url": "https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"},
                {"id": "image2", "url": "https://cdn.pixabay.com/photo/2015/04/19/08/32/rose-729509_640.jpg"},
                {"id": "image3", "url": "https://beingselfish.in/wp-content/uploads/2023/07/mahadev-dp02.jpg"},
                {"id": "image4", "url": "https://slp-statics.astockcdn.net/static_assets/staging/24winter/home/curated-collections/card-2.jpg?width=580"},
                    {"id": "image5", "url": "https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"},
                    {"id": "image6", "url": "https://cdn.pixabay.com/photo/2015/04/19/08/32/rose-729509_640.jpg"},
              ],
              "include": true,
              "backgroundColor": "#E0E0E0"
            }
          ]
        }
    """

    var body: some View {
        if let uiModel = try? JSONDecoder().decode(MyUIModel.self, from: Data(jsonData.utf8)) {
            MyScreenView(uiModel: uiModel)
                .background(Color(hex: uiModel.screen.backgroundColor))
                .navigationTitle(uiModel.screen.title)
        } else {
            Text("Failed to load UI data")
        }
    }
}

struct MyScreenView: View {
    let uiModel: MyUIModel

    var body: some View {
        VStack {
            ForEach(uiModel.components.filter { $0.include }, id: \.id) { component in
                switch component.type {
                case "grid":
                    MyImageGridView(component: component)
                default:
                    EmptyView()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct MyContentView_Previews_PreviewProvider: PreviewProvider {
    static var previews: some View {
        MycView()
    }
}



