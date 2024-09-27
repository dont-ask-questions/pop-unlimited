// Function to load SVG and fetch text from a .txt file, then insert the text into the SVG as inline content
function loadSVGWithText(svgFilePath, txtFilePath, svgContainerId) {
    // Fetch the SVG content
    fetch(svgFilePath)
        .then(response => response.text())
        .then(svgContent => {
            // Parse the SVG content string into an actual DOM element (inline SVG)
            const parser = new DOMParser();
            const svgDocument = parser.parseFromString(svgContent, "image/svg+xml");
            const svgElement = svgDocument.querySelector("svg");

            if (svgElement) {
                // Insert the inline SVG into the container
                const container = document.getElementById(svgContainerId);
                container.innerHTML = ''; // Clear any existing content
                container.appendChild(svgElement); // Append the inline SVG

                // Fetch the text content from the .txt file
                fetch(txtFilePath)
                    .then(response => response.text())
                    .then(textContent => {
                        // Select the text element inside the inline SVG and update its content
                        const svgTextElement = svgElement.querySelector("#buttonText");
                        if (svgTextElement) {
                            svgTextElement.textContent = textContent;
                        } else {
                            console.error('SVG text element not found');
                        }
                    })
                    .catch(error => console.error('Error loading text file:', error));
            } else {
                console.error('SVG element not found');
            }
        })
        .catch(error => console.error('Error loading SVG file:', error));
}

// Function to zoom in the buttons after the logo animation finishes
function zoomInButtons() {
    const newPlayerButton = document.getElementById('newPlayerButton');
    const returningPlayerButton = document.getElementById('returningPlayerButton');

    // First, zoom in the New Player button
    newPlayerButton.style.animation = "buttonZoomIn 1s forwards ease-in-out";

    // After New Player button zooms in, zoom in Returning Player button
    setTimeout(() => {
        returningPlayerButton.style.animation = "buttonZoomIn 1s forwards ease-in-out";
    }, 1000); // 1-second delay after New Player button zooms in
}

// Use a single event listener for DOMContentLoaded
document.addEventListener('DOMContentLoaded', function() {
    // Load the New Player button
    loadSVGWithText('/svgs/old login page stuf/shapes/310.svg', '/svgs/old login page stuf/texts/313.txt', 'newPlayerButton');

    // Load the Returning Player button
    loadSVGWithText('/svgs/old login page stuf/shapes/310.svg', '/svgs/old login page stuf/texts/315.txt', 'returningPlayerButton');

    // Wait for the logo to finish zooming in, then show the buttons
    setTimeout(zoomInButtons, 1500); // Logo zoom animation duration is 1.5s
    //next step: when the mouse hovers over the buttons they turn green (aka switch to the green svg)
});