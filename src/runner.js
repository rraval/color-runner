// Generated by CoffeeScript 1.6.3
(function() {
  var alpha, controls, div, init, play, _i, _len, _ref;

  alpha = function(canvas) {
    var a, b, ctx, g, r, _ref;
    ctx = canvas.getContext('2d');
    _ref = ctx.getImageData(0, 0, 1, 1).data, r = _ref[0], g = _ref[1], b = _ref[2], a = _ref[3];
    return a;
  };

  play = function(canvas1, canvas2) {
    var c, target;
    console.log('play');
    target = ((function() {
      var _i, _len, _ref, _results;
      _ref = [canvas1, canvas2];
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        c = _ref[_i];
        if (alpha(c) === 255) {
          _results.push(c);
        }
      }
      return _results;
    })())[0];
    return target != null ? target.dispatchEvent(new MouseEvent('click', {
      view: window,
      bubbles: true,
      cancelable: true
    })) : void 0;
  };

  init = (function() {
    var TIMEOUT_DECREMENT, timeout;
    TIMEOUT_DECREMENT = 10;
    timeout = 500;
    return function(e) {
      var canvas1, canvas2, decrement, end, perform;
      canvas1 = document.getElementById('color-1');
      canvas2 = document.getElementById('color-2');
      end = document.getElementById('end');
      decrement = controls.querySelector('input');
      perform = function() {
        play(canvas1, canvas2);
        if (decrement.checked) {
          timeout = Math.max(0, timeout - TIMEOUT_DECREMENT);
        }
        if (end.style['display'] !== 'block') {
          return setTimeout(perform, timeout);
        }
      };
      return setTimeout(perform, timeout);
    };
  })();

  _ref = document.querySelectorAll('.play');
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    div = _ref[_i];
    div.addEventListener('click', init);
  }

  controls = document.createElement('div');

  controls.setAttribute('style', '\
    width: 100%;\
    position: fixed;\
    bottom: 100px;\
    text-align: center;\
    color: #fff;\
    z-index: 99;\
    font-size: 20px;\
    text-shadow: 2px 2px 0 rgba(0, 0, 0, 0.2);\
');

  controls.innerHTML = '\
    Color Runner Loaded.<br/>\
    <label>\
        Time per Click <strong>(SEIZURE WARNING)</strong>\
        <input type="range" min="0" max="2000" value="500" />\
    </label>\
';

  document.body.appendChild(controls);

}).call(this);
