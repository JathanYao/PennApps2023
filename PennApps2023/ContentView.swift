import SwiftUI
import MapKit



struct ContentView: View {
    @State private var tabSelected: Tab = .scroll
    @State private var points: Int = 400
    @State private var showhome: Bool = true
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    
    var body: some View {
        ZStack {
            VStack {
                ZStack{
                    TabView(selection: $tabSelected) {
                        ForEach(Tab.allCases, id: \.rawValue) { tab in
                            HStack {
                                if tab == .scroll {
                                    scroll(points: $points)
                                }
                                if tab == .map {
                                    map(points: $points)
                                }
                                
                                if tab == .trophy {
                                    trophy(points: $points)
                                }
                                
                                if tab == .gearshape {
                                    gearshape(points: $points)
                                }
                            }
                            
                            .tag(tab)
                        }
                        
                    }
                    homepage(showhome: $showhome)
                }
                
            }
            VStack {
                Spacer()
                NavBar(selectedTab: $tabSelected, showhome: $showhome)
            }
        }
    }
}
struct homepage: View {
    @Binding var showhome: Bool
    var body: some View {
        if(showhome){
            ZStack{
                Image("bgimage").ignoresSafeArea()
                VStack{
                    Text("Welcome Back!")
                        .font(.system(size: 45, weight: .semibold))
                        .foregroundColor(.black)
                        .padding(.bottom, 200)
                    Button("Enter"){
                        showhome = false
                    }
                    .foregroundColor(.black)
                    .font(.system(size: 40, weight: .semibold))
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.green)
                            .frame(width: 200, height: 50)
                    )
                    .padding(.top, 100)
                }
            }
        }
    }
}
struct Tasks: Identifiable {
    let id = UUID()
    var point: Int
    var type: String
    var text: String
    var completed: Bool = false
}

struct scroll: View {
    @Binding var points: Int
    @StateObject var triviaManager = TriviaManager()
    
    let items: [Item] = [
        Item(title: "Trivia Game (50pt / answer)", description: "Test your environmental knowledge", num: 1),
        Item(title: "Recycling Rush (20pt / item)", description: "Beat the clock and sort items", num: 2),
        Item(title: "Box 3", description: "Description for Box 3", num: 3),
        Item(title: "Box 4", description: "Description for Box 4", num: 4),
        Item(title: "Box 5", description: "Description for Box 5", num: 5),
        Item(title: "Box 6", description: "Description for Box 6", num: 6),
    ]
    
    var body : some View {
        NavigationView {
            VStack(spacing: 40) {
                VStack(spacing: 20) {
                    Text("Trivia Game")
                    Text("Are you ready to test out your trivia skills?")
                        .foregroundColor(Color("AccentColor"))
                }
                ForEach(items) { item in
                    NavigationLink {
                        TriviaView()
                            .environmentObject(triviaManager)
                    } label: {
                        PrimaryButton(text: "Let's go!")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
                .background(Color(red: 0.984313725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
            }
            
        }
    }
    
    struct BoxView: View {
        let item: Item

        var body: some View {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
            .padding()
        }
    }
    
    struct TriviaGame: View {
        var body: some View {
            VStack(spacing: 40) {
                VStack(spacing: 20) {
                    Text("Trivia")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                    
                    Text("20 points for right answers, so get ready to test yourself!")
                    
                }
                
                NavigationLink {
                    TriviaView()
                } label: {
                    PrimaryButton(text: "Enter")
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    struct RecyclingGame: View {
        var body: some View {
            VStack {
                Text("RRR")
            }
        }
    }
    
    struct BlankPage: View {
        var body: some View {
            VStack {
                Text("Coming Soon!")
            }
        }
    }

    struct Item: Identifiable {
        let id = UUID()
        let title: String
        let description: String
        let num: Int
    }
    
  
}
struct TaskView: View {
    @Binding var points: Int
    let task: Tasks
    var onComplete: () -> Void
    var onTrivia: () -> Void
    var onCounter: () -> Void
    var body: some View {
        HStack {
            Text("\(task.point) points")
                .padding(10)
            Spacer()
            Text(task.text)
            Spacer()
            switch task.type{
            case "counter":
                Button(action: {
                    onCounter()
                }){
                    Text("start")
                        .foregroundColor(.blue)
                        .padding(20)
                }
            case "trivia":
                Button(action: {
                    onTrivia()
                }){
                    Text("start")
                        .foregroundColor(.blue)
                        .padding(20)
                }
            case "timer":
                Button(action: {
                    //onTimer()
                }){
                    Text("start")
                        .foregroundColor(.blue)
                        .padding(20)
                }
            default:
                Button(action: {
                    points += task.point
                    onComplete()
                }){
                    Text("complete")
                        .foregroundColor(.blue)
                        .padding(20)
                }
            }
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        
    }
}

struct Continent: Identifiable {
    var id = UUID()
    var name: String
    var description: String
    // Add other properties as needed
}

struct ContinentCardView: View {
    var continent: Continent
    
    var body: some View {
        VStack {
            Text("Mission Selector")
                .foregroundColor(.black)
                .font(.system(size: 40, weight: .semibold))
            
            
            Image(continent.name)
                .resizable()
                .frame(maxWidth: 300, maxHeight: 300)
            Text(continent.name)
                .font(.title)
            Text(continent.description)
                .font(.subheadline)
            // Add other continent details here
        }
        .padding()
    }
}

struct ContinentSelectorView: View {
    @State private var selectedTab = 0
    let continents: [Continent]

    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                ForEach(continents.indices, id: \.self) { index in
                    ContinentCardView(continent: continents[index])
                        .tag(index)
                    
                    
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            HStack {
                Button(action: {
                    if selectedTab > 0 {
                        selectedTab -= 1
                    }
                }) {
                    Image(systemName: "arrow.left.circle")
                        .font(.largeTitle)
                }
                Spacer()
                
                Text("Accept Mission")
                    .fontWeight(.bold)
                
                Spacer()
                Button(action: {
                    if selectedTab < continents.count - 1 {
                        selectedTab += 1
                    }
                }) {
                    Image(systemName: "arrow.right.circle")
                        .font(.largeTitle)
                }
            }
            
            
            
            
            
            .padding(50)
        }
    }
}

struct map: View {
    @Binding var points: Int
    let continents = [
        Continent(name: "North America", description: "Mission: Reduce the likelyhood of wildfires"),
        Continent(name: "South America", description: "Mission: Save the biodiversity and forests"),
        Continent(name: "Europe", description: "Mission: Fight the heat waves"),
        Continent(name: "Asia", description: "Mission: Reduce pollution"),
        Continent(name: "Africa", description: "Mission: Fight droughts and water shortages"),
        Continent(name: "Oceania", description: "Mission: Protect the coral reefs and aquatic life"),
        Continent(name: "Antarctica", description: "Mission: Prevent the ice caps from melting"),
        // Add more continents as needed
    ]
    
    var body: some View {
        ContinentSelectorView(continents: continents)
            .padding()
    }
}

struct leaderboards: View {
    var dim: [CGFloat]
    var texts: [String]
    var colour: Color
    var body: some View {
        HStack {
            Text(texts[0])
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.black)
                .padding(20)
            Spacer()
            Text(texts[1])
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "dollarsign.circle.fill")
                .foregroundColor(.yellow)
            Text(texts[2])
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 80, height: 25)
                .background(.green)
                .cornerRadius(25)
            
                .padding(.trailing, 15)
        }
        .frame(width: dim[0], height: dim[1])
        .background(colour)
        .cornerRadius(10)
        .padding(dim[2])
    }
}
struct trophy: View {
    @Binding var points: Int
    var body: some View {
        ZStack {
            Color("lightgreen").ignoresSafeArea()
            VStack{
                Text("Leaderboard")
                    .foregroundColor(.black)
                    .font(.system(size: 40, weight: .semibold))
                HStack(alignment: .bottom){
                    ZStack{
                        VStack{
                            Image(systemName: "trophy.circle")
                                .foregroundColor(.gray)
                                .font(.system(size: 70))
                            Rectangle()
                                .fill(.gray.opacity(0.2))
                                .frame(width: 120, height: 180, alignment: .top)
                        }
                        VStack{
                            Text("2. Jane")
                                .font(.system(size: 25, weight: .semibold))
                                .padding(.top, 25)
                            Text("350")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 80, height: 25)
                                .background(.green)
                                .cornerRadius(25)
                        }
                    }
                    ZStack{
                        VStack{
                            Image(systemName: "trophy.circle")
                                .foregroundColor(.yellow)
                                .font(.system(size: 70))
                            Rectangle()
                                .fill(.gray.opacity(0.2))
                                .frame(width: 120, height: 210, alignment: .top)
                        }
                        VStack{
                            Text("1. User")
                                .font(.system(size: 25, weight: .semibold))
                            Text("400")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 80, height: 25)
                                .background(.green)
                                .cornerRadius(25)
                        }
                    }
                    ZStack{
                        VStack{
                            Image(systemName: "trophy.circle")
                                .foregroundColor(.brown)
                                .font(.system(size: 70))
                            Rectangle()
                                .fill(.gray.opacity(0.2))
                                .frame(width: 120, height: 150, alignment: .top)
                        }
                        VStack{
                            Text("3. Adam")
                                .padding(.top, 50)
                                .font(.system(size: 25, weight: .semibold))
                            Text("320")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 80, height: 25)
                                .background(.green)
                                .cornerRadius(25)
                        }
                    }
                }
                ScrollView(.vertical, showsIndicators: false) {
                    leaderboards(dim: [370, 40, 0], texts: ["4.", "Samantha", "260"], colour: .white)
                    leaderboards(dim: [370, 40, 0], texts: ["5.", "Darryl", "150"], colour: .white)
                    leaderboards(dim: [370, 40, 0], texts: ["6.", "Mike", "90"], colour: .white)
                    leaderboards(dim: [370, 40, 0], texts: ["7.", "Nathan", "20"], colour: .white)
                    VStack() {
                        ForEach(8..<21) { i in
                            leaderboards(dim: [370, 40, 0], texts: ["\(i).", "Username\(i)", "0"], colour: .white)
                        }
                    }
                }
            }
        }
    }
}
struct achievement: View {
    var texts: [String]
    var completed: Bool
    var body: some View {
        HStack {
            if(completed){
                Image(systemName: "star.circle.fill")
                    .font(.system(size: 40))
                    .padding(.leading, 20)
                    .foregroundColor(.yellow)
            }else{
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 40))
                    .padding(.leading, 20)
            }
            VStack(alignment: .leading){
                Text(texts[0])
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                Text(texts[1])
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.black)
            }
            Spacer()
            if(completed){
                Image(systemName:"checkmark.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.green)
                    .padding(20)
            }
            else{
                Text(texts[2])
                    .font(.system(size: 15, weight: .semibold))
                    .frame(width: 100, height: 25)
                    .background(.blue.opacity(0.3))
                    .cornerRadius(25)
                    .padding(.trailing, 15)
            }
        }
        .frame(width: 330, height: 60)
        .background(.blue.opacity(0.1))
        .cornerRadius(10)
    }
}
struct gearshape: View {
    @Binding var points: Int
    
    var body: some View {
        ZStack{
            Color("lightblue").ignoresSafeArea()
            ScrollView {
                VStack{
                    HStack{
                        Spacer()
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 180))
                            .foregroundColor(.blue)
                        Spacer()
                    }
                    HStack(alignment: .bottom){
                        Text("User")
                            .padding(.leading, 28)
                            .font(.system(size: 40, weight: .semibold))
                            .padding(.bottom, 1)
                            .multilineTextAlignment(.center)
                        Image(systemName: "pencil.line")
                            .font(.system(size: 25))
                            .padding(.bottom, 9)
                    }
                    ZStack{
                        Rectangle()
                            .frame(width: 360, height: 70)
                            .foregroundColor(.white.opacity(0.6))
                            .cornerRadius(15)
                        HStack{
                            Spacer()
                            VStack{
                                Text("9")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 30, weight: .semibold))
                                Text("Friends")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 15, weight: .semibold))
                            }
                            Spacer()
                            VStack{
                                Text("27")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 30, weight: .semibold))
                                Text("Tasks")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 15, weight: .semibold))
                            }
                            Spacer()
                            VStack{
                                Text("6")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 30, weight: .semibold))
                                Text("Countries")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 15, weight: .semibold))
                            }
                            Spacer()
                        }
                    }
                    
                    ZStack{
                        Rectangle()
                            .frame(width: 360, height: 800)
                            .foregroundColor(.white.opacity(0.6))
                            .cornerRadius(15)
                        VStack{
                            HStack{
                                Text("Achievements")
                                    .padding(.top, 20)
                                    .font(.system(size: 40, weight: .semibold))
                                    .multilineTextAlignment(.center)
                            }
                            achievement(texts: ["Greenie", "Complete 10 tasks", "50 points"], completed: true)
                            achievement(texts: ["Novice", "Complete 20 tasks", "100 points"], completed: true)
                            achievement(texts: ["Just Starting", "Unlock your first country", "50 points"], completed: true)
                            achievement(texts: ["Globetrotter", "Unlock 5 counties", "100 points"], completed: true)
                            achievement(texts: ["Nature Lover", "Complete 30 tasks", "150 points"], completed: false)
                            achievement(texts: ["Tree Hugger", "Complete 50 tasks", "200 points"], completed: false)
                            achievement(texts: ["Mr. Worldwide", "Unlock 10+ countries", "200 points"], completed: false)
                            achievement(texts: ["The Lorax", "Complete 100 tasks", "500 points"], completed: false)
                            Spacer()
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
