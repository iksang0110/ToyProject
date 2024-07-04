const API_URL = 'https://libretranslate.de/translate';

document.addEventListener('DOMContentLoaded', function() {
    const inputField = document.getElementById('inputField');
    const translation = document.getElementById('translation');
    let debounceTimer;

    inputField.addEventListener('input', function() {
        clearTimeout(debounceTimer);
        debounceTimer = setTimeout(() => {
            const text = inputField.value.trim();
            if (text) {
                translateText(text); // 사용자 입력을 실시간으로 번역
            }
        }, 250); // 500밀리초 디바운싱
    });

    function translateText(text) {
        fetch(API_URL, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                q: text,
                source: 'ko',
                target: 'en',
                format: 'text',
            }),
        })
        .then(response => response.json())
        .then(data => {
            if (data && data.translatedText) {
                translation.textContent = data.translatedText; // 번역된 텍스트를 표시
            }
        })
        .catch(error => console.error('Error translating text:', error));
    }
});
