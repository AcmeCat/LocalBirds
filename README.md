# ![mac64](https://github.com/user-attachments/assets/76603188-9d38-4119-ae94-571a4b169e59) LocalBirds 
**LocalBirds** is a clean, focused iOS app built for amateur and seasoned birders alike. Whether you're logging sightings on a morning walk, building out detailed checklists, or browsing bird facts, this app is designed to keep your birding experience swift, smart, and joyful.

## Features
- Log Bird Sightings with species, time, and location
- Create and Update Checklists in real time as you log
- Browse Bird Species Info using data from the Nuthatch API
- Haptic Feedback for persistence confirmation (toggle in settings)
- Dynamic Light/Dark Mode support
- Tabbed Navigation for Checklists, Bird Info, and Settings

## Acceptance Criteria
**Logging Sightings**
- *Given* I spot a bird
- - *When* I log a sighting using the app
- - - *Then* the new sighting is saved and reflected immediately in relevant checklists

**Real-time Checklist Updates**
- *Given* I’ve logged one or more bird sightings
- - *When* I navigate to the Checklists tab
- - - *Then* I see an up-to-date list of all species I’ve observed

**Bird Info Lookup**
- *Given* I want to learn more about a bird species
- - *When* I open the Bird Info tab
- - - *Then* I can browse or search species and view details via the Nuthatch API

**Haptic Feedback Toggle**
- *Given* I’m in the Settings tab
- - *When* I toggle haptic feedback
- - - *Then* the app will vibrate slightly to confirm saves only if enabled

**Light & Dark Mode**
- *Given* my device theme is set to light or dark
- - *When* I open LocalBirds
- - - *Then* the UI adapts automatically to match my system appearance

## Tools
| Tech | Purpose |
| --------- | --------- |
| Swift	| Primary development language |
| SwiftUI	| Declarative UI framework |
| Core Data	| Local persistence for sightings & lists |
| Nuthatch API | External data source for bird species |
| XCTest | Unit testing of ViewModels and logic |
| Haptics API | Taptic Engine feedback on actions |

## Architecture
**LocalBirds** uses a modular MVVM structure for its UI/Presentation layer, with Core Data handling local persistence and the *Nuthatch API* for live bird information.
```
LocalBirds
├── Models
│   ├── BirdSpecies
│   ├── Sighting
│   └── Checklist
├── ViewModels
│   ├── ChecklistViewModel
│   ├── BirdInfoViewModel
│   └── SettingsViewModel
├── Views
│   ├── ChecklistsTabView
│   ├── BirdInfoTabView
│   ├── SettingsTabView
│   └── AddSightingView
├── Services
│   └── BirdAPIService.swift (Nuthatch API wrapper)
├── Persistence
│   └── CoreDataStack.swift
└── Tests
    └── LocalBirdsTests.swift
```

## API Contract
**`/species` endpoint:
```
[
  {
    "id": "abc123",
    "common_name": "Rainbow Lorikeet",
    "scientific_name": "Trichoglossus moluccanus",
    "image_url": "https://nuthatchapi.com/images/rainbow_lorikeet.jpg",
    "description": "A vibrant, noisy parrot commonly found in Australian suburbs.",
    "habitat": "Woodlands, gardens, coastal regions",
    "conservation_status": "Least Concern"
  },
  {
    "id": "def456",
    "common_name": "Superb Fairywren",
    "scientific_name": "Malurus cyaneus",
    "image_url": "https://nuthatchapi.com/images/superb_fairywren.jpg",
    "description": "A small bird with brilliant blue plumage on the male.",
    "habitat": "Shrublands, grasslands",
    "conservation_status": "Least Concern"
  }
]
```
**`/checklists` endpoint**
```
[
  {
    "id": "checklist_001",
    "title": "Garden Birds",
    "created_at": "2025-06-01T08:15:30Z",
    "updated_at": "2025-06-15T11:00:00Z",
    "checked_species": [
      "abc123",
      "def456",
      "ghi789"
    ],
    "notes": "Backyard sightings only. Mostly in the morning."
  },
  {
    "id": "checklist_002",
    "title": "Albany Trip 2025",
    "created_at": "2025-05-10T10:00:00Z",
    "updated_at": "2025-05-18T16:30:00Z",
    "checked_species": [],
    "notes": null
  }
]
```
**BirdSpeciesDTO**
```
struct BirdSpeciesDTO: Codable, Identifiable {
    let id: String
    let commonName: String
    let scientificName: String
    let imageURL: URL
    let description: String
    let habitat: String
    let conservationStatus: String

    enum CodingKeys: String, CodingKey {
        case id
        case commonName = "common_name"
        case scientificName = "scientific_name"
        case imageURL = "image_url"
        case description
        case habitat
        case conservationStatus = "conservation_status"
    }
}
```
**ChecklistDTO**
```
struct ChecklistDTO: Codable, Identifiable {
    let id: String
    let title: String
    let createdAt: Date
    let updatedAt: Date
    let checkedSpecies: [String]
    let notes: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case checkedSpecies = "checked_species"
        case notes
    }
}
```
## Screens
| ![IMG_2648](https://github.com/user-attachments/assets/db542e4a-e3b4-4626-915b-51f5a99dea8f) | ![IMG_2649](https://github.com/user-attachments/assets/40a655c9-e70f-49ac-81a4-fe60dd49bc77) | ![IMG_2650](https://github.com/user-attachments/assets/a0fdc561-d67e-41b9-9499-a7cda54f32fe) |
| --------- | ---------- | ---------- |
| Welcome Screen (Bird-of-the-day and Checklist selection) | Detail View (from Welcome Screen) | Sightings View (from Welcome Screen) |

| ![IMG_2651](https://github.com/user-attachments/assets/086b7d49-e5b1-4091-aa20-98e4159d7d55) | ![IMG_2652](https://github.com/user-attachments/assets/0b829d08-16c1-476b-b944-2c11d4191a10) | ![IMG_2664](https://github.com/user-attachments/assets/db9380d0-b0ae-40fb-98fd-fe70d599e6a0) |
| --------- | ---------- | ---------- |
| Add New Sighting (presented as sheet) | Detail View (from selection in Birds list) | Settings View |

## ToDos
- [x] Bird of the day
- [x] Offline reference support
- [ ] iCloud sync
- [ ] Locale integration
