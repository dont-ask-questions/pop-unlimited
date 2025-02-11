//for the pieces with multiple parts, we will tell js, "for this number or whatever, i would like you to put these svgs in this certain arrangement" and then have it print a div with the arrangement in our html code. it has to go inside our defaultAppearances.json file then our hair.json file.
import json

fetch('defaultAppearances.json')
    .then(response => response.json())
    .then(data => {
        document.body.innerHTML = data.html_content; // Render the HTML content
    });


fetch('http://127.0.0.1:2007/get_character_data')
    .then(response => response.json())
    .then(data => {
        console.log("Character Data:", data);
        
        // Example: Display random male hair
        let randomHair = data.defaultAppearances.male.hair[Math.floor(Math.random() * data.defaultAppearances.male.hair.length)];
        console.log("Random Hair SVG:", randomHair);
        
        // You can now use `randomHair` to set the SVG in the HTML
        document.getElementById("hair-svg").src = randomHair;
    })
    .catch(error => console.error("Error fetching character data:", error));