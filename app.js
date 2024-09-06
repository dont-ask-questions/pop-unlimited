// Load gender SVG bubbles dynamically
function loadGenderBubbles() {
    const genderBubbles = document.getElementById('gender-bubbles');

    // Load Boy bubble
    fetch('/static/assets/boy.svg') //a placeholder until i can find these gender bubbles ;-;
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
    document.getElementById('creation-box').style.display = 'block';
    loadGenderBubbles();  // Load the gender bubbles
}

function handleGenderSelection(gender) {
    console.log("Player selected gender: " + gender);
    // Proceed to age selection after gender is chosen
    startAgeSelection();
}