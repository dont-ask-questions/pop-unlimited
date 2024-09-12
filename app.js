function loadSVGWithText(svgFilePath, txtFilePath, svgContainerId) {
    // Fetch the SVG content
    fetch(svgFilePath)
        .then(response => response.text())
        .then(svgContent => {
            // Insert the SVG content into the specified container
            document.getElementById(svgContainerId).innerHTML = svgContent;

            // Fetch the text content from the .txt file
            fetch(txtFilePath)
                .then(response => response.text())
                .then(textContent => {
                    // Select the text element inside the SVG and update its content
                    const svgTextElement = document.querySelector(`#${svgContainerId} #buttonText`);
                    if (svgTextElement) {
                        svgTextElement.textContent = textContent;
                    }
                })
                .catch(error => console.error('Error loading text file:', error));
        })
        .catch(error => console.error('Error loading SVG file:', error));
}

// Call this function to load the SVG and text into the New Player button
document.addEventListener('DOMContentLoaded', function() {
    loadSVGWithText('/svgs/old login page stuf/shapes/310.svg', '/svgs/old login page stuf/texts/313.txt', 'newPlayerButton');
});

document.addEventListener('DOMContentLoaded', function() {
    loadSVGWithText('/svgs/old login page stuf/shapes/310.svg', '/svgs/old login page stuf/texts/315.txt', 'returningPlayerButton');
});