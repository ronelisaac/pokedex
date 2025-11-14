# pokedex
📱 Pokédex — iOS App

Un app para challenge Cencosud moderna construida en SwiftUI, con arquitectura modular, network layer robusto, persistencia local, animaciones avanzadas y tests unitarios.

🚀 Características
🧠 Arquitectura

SwiftUI + MVVM

Modular: Data, Domain, Repository, Presentation

Inyección de dependencias simple

Capa de red con async/await usando Alamofire

Manejo de errores profesional con banners animados

🔍 Capa de Red

Cliente PokeAPIClient totalmente mockeable

Modelos del API (List, Detail, Species)

NetworkError altamente descriptivo

Decodificación segura y rápida

🎨 Design System

Colores DSColor

Tipografías DSFont

Spacings

Componentes reutilizables como:

SearchBar

PokemonCardGridItem

FavoritePokemonCard

SpriteCarouselView

DSLoader

BannerView (errores)

RecentSearchChipsView

🐱 Pantallas
Pantalla	Descripción
Pokédex	Búsqueda, infinite scroll, error banner
Detalle	Carrusel animado con auto-play
Favoritos	Guardado local, animaciones 3D
Historial	Últimas búsquedas con chips
💾 Persistencia

CoreData para Favoritos

UserDefaults para historial de búsquedas

Repositorios:

FavoritesRepositoryCoreData

SearchHistoryStore

🧪 Tests

Mocks de Network y Repository

Tests de éxito y error

Extensiones con modelos sample para testeo

🛠 Requisitos

Xcode 15+

iOS 17+

Swift 5.9+

📦 Instalación
git clone https://github.com/ronelisaac/pokedex.git
cd pokemones
open pokemones.xcodeproj


Compila y ejecuta en el simulador.

🏗 Estructura del proyecto

<img width="662" height="456" alt="Captura de pantalla 2025-11-14 a la(s) 3 50 16 p  m" src="https://github.com/user-attachments/assets/b9e38dc3-dac4-4ea3-96ca-fbccf7f6beb4" />



📸 Screenshots

<img width="254" height="600" alt="Simulator Screenshot - iPhone 17 - 2025-11-14 at 15 54 39" src="https://github.com/user-attachments/assets/17edb50d-9cd4-467f-88cf-0d53b719ca91" />  <img width="254" height="600" alt="Simulator Screenshot - iPhone 17 - 2025-11-14 at 15 54 51" src="https://github.com/user-attachments/assets/1d7aa427-f49a-4258-abae-d238bc440ae1" />    
<img width="254" height="600" alt="Simulator Screenshot - iPhone 17 - 2025-11-14 at 15 54 53" src="https://github.com/user-attachments/assets/e5efc860-91c6-487b-bae7-6c37d87f5412" />   <img width="254" height="600" alt="Simulator Screenshot - iPhone 17 - 2025-11-14 at 15 55 10" src="https://github.com/user-attachments/assets/0dedc6cd-9205-4f7f-be90-abc6f5a35b0e" />   <img width="254" height="600" alt="Simulator Screenshot - iPhone 17 - 2025-11-14 at 15 55 22" src="https://github.com/user-attachments/assets/c3b1b652-9cd1-47c0-b09f-aa538a94e8e3" />





📄 Licencia

MIT License.

