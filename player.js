// Function to generate a random color in hexadecimal format
function getRandomColor() {
    const randomColor = Math.floor(Math.random() * 16777215).toString(16); // Generates a random number and converts it to hex
    return `#${randomColor.padStart(6, '0')}`; // Ensures the color is always 6 digits
}

// Function to change the color of the headcolor SVG
function changeHeadColor() {
    const headColorObject = document.querySelector('.headcolor');

    // Access the SVG document
    const svgDoc = headColorObject.contentDocument;

    // Change the fill color of all paths to a random color
    const paths = svgDoc.querySelectorAll('path');
    paths.forEach(path => {
        path.setAttribute('fill', getRandomColor()); // Set a random color for each path
    });
}

// Function to change color on key press
function changeColorOnKeyPress(event) {
    if (event.key === 's' || event.key === 'S') { // Check if the 'S' key is pressed
        console.log("test");
        changeHeadColor(); // Call the function to change colors
    }
}

// Set up the initial color change on load
document.addEventListener('DOMContentLoaded', function() {
    const headColorObject = document.querySelector('.headcolor');

    // Ensure the SVG has loaded
    const outlineObject = document.querySelector('.outline');
    outlineObject.addEventListener('load', function() {
        // Call changeHeadColor once the SVG is loaded to set initial colors
        changeHeadColor();
    });

    headColorObject.addEventListener('load', function() {
        // Ensure both SVGs are ready before combining
        const svgDoc = headColorObject.contentDocument;
        const paths = svgDoc.querySelectorAll('path');
        paths.forEach(path => {
            path.setAttribute('fill', getRandomColor()); // Set initial random colors
        });
    });
});

// Add event listener for keydown event
document.addEventListener('keydown', changeColorOnKeyPress);