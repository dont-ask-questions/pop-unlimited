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
        pupils.setAttribute('transform', `translate(${46.5 + pupilX}, ${29.0 + pupilY})`);
    });
});