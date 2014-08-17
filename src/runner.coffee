alpha = (canvas) ->
    ctx = canvas.getContext('2d')
    [r, g, b, a] = ctx.getImageData(0, 0, 1, 1).data
    return a

play = (canvas1, canvas2) ->
    [target] = (c for c in [canvas1, canvas2] when alpha(c) == 255)
    target?.dispatchEvent(new MouseEvent('click', {
        view: window,
        bubbles: true,
        cancelable: true,
    }))

init = (e) ->
    canvas1 = document.getElementById('color-1')
    canvas2 = document.getElementById('color-2')
    end = document.getElementById('end')

    input = controls.querySelector('input')
    getTimeout = -> parseInt(input.value, 10)

    perform = ->
        play(canvas1, canvas2)
        setTimeout(perform, getTimeout()) unless end.style['display'] == 'block'

    setTimeout(perform, getTimeout())

for div in document.querySelectorAll('.play')
    div.addEventListener('click', init)

controls = document.createElement('div')
controls.setAttribute('style', '
    width: 100%;
    position: fixed;
    bottom: 100px;
    text-align: center;
    color: #fff;
    z-index: 99;
    font-size: 20px;
    text-shadow: 2px 2px 0 rgba(0, 0, 0, 0.2);
')

controls.innerHTML = '
    Color Runner Loaded. Time per Click:<br />
    <label>
        <strong style="vertical-align:middle">(SEIZURE WARNING) Fast</strong>
        <input style="vertical-align:middle" type="range" min="0" max="2000" value="500" />
        <strong style="vertical-align:middle">Slow</strong>
    </label>
'

document.body.appendChild(controls)
