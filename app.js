// Load text from .txt file and insert it into the element with a specific font
function loadGameText(filePath, elementId) {
    fetch(filePath)
        .then(response => response.text())
        .then(textContent => {
            const textElement = document.getElementById(elementId);
            textElement.innerText = textContent;  // Insert the text into the specified element
            textElement.style.fontFamily = 'PromptFont';  // Apply custom font (you'll define this in CSS)
        })
        .catch(error => console.error('Error loading text:', error));
}

// Load gender SVG bubbles dynamically
function loadGenderBubbles() {
    const genderBubbles = document.getElementById('gender-bubbles');

    // Load Boy bubble
    fetch('.../svgs/old login page stuf/svgs put together/boy_bubble.svg')
        .then(response => response.text())
        .then(svgContent => {
            const boyBubble = document.createElement('div');
            boyBubble.innerHTML = svgContent;
            boyBubble.id = 'boyBubble';
            boyBubble.classList.add('gender-bubble');
            genderBubbles.appendChild(boyBubble);

            // Add click event for boy selection
            boyBubble.addEventListener('click', function() {
                handleGenderSelection('boy');
            });
        });

    // Load Girl bubble
    fetch('/static/assets/girl.svg')
        .then(response => response.text())
        .then(svgContent => {
            const girlBubble = document.createElement('div');
            girlBubble.innerHTML = svgContent;
            girlBubble.id = 'girlBubble';
            girlBubble.classList.add('gender-bubble');
            genderBubbles.appendChild(girlBubble);

            // Add click event for girl selection
            girlBubble.addEventListener('click', function() {
                handleGenderSelection('girl');
            });
        });
}

// Trigger gender bubble loading after the box rises
function riseBoxAnimation() {
    // Display the creation box
    document.getElementById('creation-box').style.display = 'block';

    // Load the gender prompt text
    loadGameText('.../svgs/old login page stuf/texts/437.txt', 'promptText');  // Load text for "Are you a boy or a girl?"

    // Load the gender SVG bubbles
    loadGenderBubbles();
}

function handleGenderSelection(gender) {
    console.log("Player selected gender: " + gender);
    // Proceed to age selection after gender is chosen
    startAgeSelection();
}

// Example function for starting age selection
function startAgeSelection() {
    // This would handle the transition to age selection after gender selection
    console.log("Starting age selection...");
}

