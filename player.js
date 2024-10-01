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