### Summary
This application is a take home exercise for Fetch.

Included functionality:
- Network handling, pulling data from Fetch provided API
- Image caching
- MVVM for abstraction and ensuring required data for UI
- Swift Concurrency: `async / await` for cleaner code
- Tests to ensure expected ImageCaching behavior, and for ensuring expected data from Recipe API
- List sorting based on "name" and "cuisine" fields
- Sheet/modal view for viewing recipe details, provided by `sourceURL` or `youtubeURL`

<img src="https://github.com/user-attachments/assets/ed9944f9-094e-4aa8-b6c7-671c3ca5e971" width="300">
<img src="https://github.com/user-attachments/assets/66805ba2-f121-4647-8777-bb30a8109b43" width="300">
<img src="https://github.com/user-attachments/assets/88a0fdbf-94bf-4533-b4d3-b046956bf555" width="300">

### Focus Areas
I prioritized features specifically listed in the [take home exercise instructions](https://d3jbb8n5wk0qxi.cloudfront.net/take-home-project.html), as well as clean and useful UI for actually browsing and viewing recipe content. The reason I focused on these areas are because I wanted to make sure reviewers are confident that I can do the tasks listed, and also to make sure the app was pleasant to use from a UI perspective.

### Time Spent
This project took me three nights spread out over a week. I started by pulling and displaying data on night 1, then handling image caching on night 2, and finally writing a view model and tests on night 3.

### Trade-offs and Decisions
One consideration I had was for a detail view for each list item. However, a detail view was not asked for, and the URL's which were included with each item (at least a source or youtube url was available for each item) served as good detail for each recipe. So I decided against a detail view, meaning there was no need for the included large image url. Additionally, this allows the user to get straight into the recipe details. I considered adding search UI and functionality, but this was also not required, and while I would likely include this in a real project, I figured in this case I'd save myself the time.

### Weakest Part of the Project
If I had to decide on the weakest part of the project, I'd say the `NetworkManager` isn't very fleshed out. It simply fetches recipes, which means it's not managing much network handling at all. However, this is because I decided to do only what was necessary for this take home exercise.

### Additional Information
I hope this take home project shows my commitment to clean, simple, highly readable code, and a care for intuitive user-interface design, as well as my knowledge and insight around common concepts including network and cache handling, as well as extensions management, and testing, wrapped in a clean file structure/architecture.
