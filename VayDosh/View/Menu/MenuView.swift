//
//  MenuView.swift
//  VayDosh
//
//  Created by Adam Miziev on 5/5/23.
//

import SwiftUI

struct MenuView: View {
    @AppStorage("displayMode") private var displayMode = DisplayMode.system
    @AppStorage("language") private var language = 
    LocalizationService.shared.language
    
    
    @FetchRequest(entity: Item.entity(), sortDescriptors:
                    [NSSortDescriptor(keyPath: \Item.dictionary,
                                      ascending: true)])
    var results : FetchedResults<Item>
    
    @EnvironmentObject var appIconModel: AppIconModel
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink(destination: VocabularyView()) {
                        CustomButton(title: "VayDosh", 
                                     subTitle: "Composition",
                                     icon: "books.vertical",
                                     iconColor: .accentColor)
                    }.buttonStyle(PlainButtonStyle())
                    NavigationLink(destination: FavoriteListView()) {
                        CustomButton(title: "Favorites", subTitle: "", 
                                     icon: "star.fill")
                    }.buttonStyle(PlainButtonStyle())
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, 
                                    trailing: 10))
                List {
                    Section (header: VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "paintbrush")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.accentColor)
                            Text("Appearance".localized(language))
                        }
                    }) {
                        NavigationLink(destination: IconChooser()) {
                            HStack {
                                Text("Icon".localized(language))
                                Spacer()
                                Text(appIconModel.appIcon.description.localized(
                                    language))
                                    .foregroundColor(Color.accentColor)
                            }
                        }
                        HStack {
                            Text("Color Scheme:".localized(language))
                                .font(.callout)
                            Picker("Is Dark?", selection: $displayMode) {
                                Text("Auto".localized(language)).tag(
                                    DisplayMode.system)
                                Text("Dark".localized(language)).tag(
                                    DisplayMode.dark)
                                Text("Light".localized(language)).tag(
                                    DisplayMode.light)
                            }
                            .pickerStyle(.segmented)
                            .onChange(of: displayMode) { newValue in
                                displayMode.setAppDisplayMode()
                            }
                            .padding(.trailing, -10)
                            
                        }
                        .listRowSeparator(.hidden)
                    }
                    
                    Section(content: {
                        Link(destination: URL(string: 
                                                "https://t.me/adammiziev")!) {
                            HStack {
                                Image("telegram")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                                    .padding(.leading, -3.5)
                                Text("Support".localized(language))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 10, height: 12.5)
                            }
                            .foregroundColor(Color(red: 0.152, green: 
                                                    0.66, blue: 0.916))
                        }
                    })
                    
                    Section {
                        NavigationLink(destination: InfoView()) {
                            HStack {
                                Image(systemName: "info.circle")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                Text("About".localized(language))
                            }
                        }
                    }
                    //                    Section {
                    //                        Button {
                    //                            // Clearing data in Core Data.
                    //                            do{
                    //                                results.forEach { (word) in
                    //                                    context.delete(word)
                    //                                }
                    //                                try context.save()
                    //                            }
                    //                            catch{
                    //                                print(error.localizedDescription)
                    //                            }
                    //                        } label: {
                    //                            Text("Update VayDosh")
                    //                        }
                    //                    }
                }
                .onAppear {
                    UIScrollView.appearance().isScrollEnabled = false
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Menu".localized(language))
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Text("VayDosh Interface Language:".localized(
                                language))
                            Button {
                                LocalizationService.shared.language = .ingush
                            } label: {
                                Text("Soon".localized(language))
                                //                            Text("Г1алг1ай")
                                Image("INH")
                            }
                            .disabled(true)
                            Button {
                                LocalizationService.shared.language = .russian
                            } label: {
                                Text("Russian".localized(language))
                                Image("RU")
                            }
                            Button {
                                LocalizationService.shared.language = 
                                    .english_us
                            } label: {
                                Text("English (US)".localized(language))
                                Image("US")
                            }
                        } label: {
                            Spacer()
                            Image(language.userSymbol.uppercased())
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 30, height: 30)
                                .shadow(radius: 2)
                        }
                        .padding(.trailing, 10)
                        .padding(.bottom, 15)
                    }
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
            }
        } // NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(AppIconModel())
    }
}
