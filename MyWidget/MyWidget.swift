//
//  MyWidget.swift
//  MyWidget
//
//  Created by 박종훈 on 2021/10/06.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), text: "", configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(),
                                text: "",
                                configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        //appgroups에서 값을 받아와서 다른 앱(위젯이 아닌 실제 앱)에서 전달한 내용을 가져온다.
        let userDefaults = UserDefaults(suiteName: "group.storyboardtutorialwidgetscache")
        //가져온 데이터를 이용해 내용을 받는 변수 정의.
        let text = userDefaults?.value(forKey: "text") as? String ?? "No Text"
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            //전달받은 내용을 이용한 텍스트라는 변수를 받는 객체 생성
            let entry = SimpleEntry(date: entryDate,
                                    text: text,
                                    configuration: configuration)
            //객체를 큐에 추가
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
//실제로 사용될 여러 데이터를 저장
struct SimpleEntry: TimelineEntry {
    let date: Date
    let text: String
    let configuration: ConfigurationIntent
}

struct MyWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        //실제 보여지는 부분 작성
        ZStack {
            //이미지를 자체 크기, 좌표 공간의 함수로 정의
            GeometryReader { geo in
                Image("background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width,
                           height: geo.size.height,
                           alignment: .center)
            }
            //텍스트
            Text(entry.text)
                .font(Font.system(size: 24, weight: .bold, design: .default))//폰트 크기, 굵기, 생김새를 결정
                .foregroundColor(Color.black)
        }
    }
}

@main
struct MyWidget: Widget {
    let kind: String = "MyWidget"
    //위젯 표시
    var body: some WidgetConfiguration {
        //intentdefinition 파일을 생성한다.
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            //위젯의 UI를 표현되는 실제 바디 함수
            MyWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")//위젯의 이름을 표시
        .description("This is an example widget.")//위젯의 설명을 표시
    }
}

struct MyWidget_Previews: PreviewProvider {
    static var previews: some View {
        MyWidgetEntryView(entry: SimpleEntry(date: Date(), text: "Hello Widget!", configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
