// Darken color function
function darkenColor(color) {
    // Convert named color (like 'red') to RGB using a dummy element
    let dummy = document.createElement("div");
    dummy.style.color = color;
    document.body.appendChild(dummy);
    let rgb = getComputedStyle(dummy).color;
    document.body.removeChild(dummy);

    // Extract RGB values
    let rgbMatch = rgb.match(/rgb\((\d+),\s*(\d+),\s*(\d+)\)/);
    if (rgbMatch) {
        let [_, r, g, b] = rgbMatch.map(Number);
        r = Math.max(0, Math.round(r * 0.6));
        g = Math.max(0, Math.round(g * 0.6));
        b = Math.max(0, Math.round(b * 0.6));
        return `rgb(${r}, ${g}, ${b})`;
    }

    return color; // Return original if no match
}



function getRandomColor() {
    const letters = '0123456789ABCDEF';
    let color = '#';
    for (let i = 0; i < 6; i++) {
        color += letters[Math.floor(Math.random() * 16)];
    }
    return color;
}

document.addEventListener('keydown', (event) => {
    if (event.key === 's' || event.key === 'S') {
        const headColor = document.getElementById('head_color');
        headColor.setAttribute('fill', getRandomColor());
      
      const darkerColor = darkenColor(headColor.getAttribute('fill'));

        const eyelids = document.getElementById('eyelids_color');
        eyelids.setAttribute('fill', headColor.getAttribute('fill'));

        const bodyColor = document.getElementById('body_color');
        bodyColor.setAttribute('fill', headColor.getAttribute('fill'));
      
      const armColor = document.getElementById('arm_color');
        armColor.setAttribute('stroke', darkerColor);
      
      const arm2Color = document.getElementById('arm2_color');
        arm2Color.setAttribute('stroke', armColor.getAttribute('stroke'));
      
      const handColor = document.getElementById('hand_color');
        handColor.setAttribute('fill', armColor.getAttribute('stroke'));
      
      const hand2Color = document.getElementById('other_hand');
        hand2Color.setAttribute('fill', handColor.getAttribute('fill'));

        /*const arms = document.getElementById('arms_color');
        arms.setAttribute('fill', headColor.getAttribute('fill'));*/
        /*these are just gonna be line svgs for now, i cannot find them*/
    }
});
document.addEventListener('DOMContentLoaded', function() {
    const pupils = document.getElementById('pupils'); // Group containing both pupils

    document.addEventListener('mousemove', function(event) {
        const eyesSvg = document.getElementById('eyes_svg');
        const eyesBox = eyesSvg.getBoundingClientRect();

        // Approximate center of the eyes (you may need to adjust these values based on your design)
        const eyeCenterX = eyesBox.left + eyesBox.width / 2;
        const eyeCenterY = eyesBox.top + eyesBox.height / 2;

        const maxPupilMovement = 10; // Maximum movement inside the eye

        // Calculate the mouse position relative to the center of the eyes
        const mouseX = event.clientX;
        const mouseY = event.clientY;

        // Calculate the angle and distance for pupil movement
        const angle = Math.atan2(mouseY - eyeCenterY, mouseX - eyeCenterX);
        const distance = Math.min(maxPupilMovement, Math.hypot(mouseX - eyeCenterX, mouseY - eyeCenterY));

        // Calculate the new pupil positions
        const pupilX = Math.cos(angle) * distance;
        const pupilY = Math.sin(angle) * distance;

        // Apply the transformation to the pupils group (move it down based on calculated values)
        pupils.setAttribute('transform', `translate(${48.5 + pupilX}, ${29.0 + pupilY})`);
    });
});



//i am gonna add a few animation functions and then run them. first we have walking...


