var Zepto = function() {
    function t(t) {
        return null == t ? String(t) : X[W.call(t)] || "object";
    }
    function e(e) {
        return "function" == t(e);
    }
    function n(t) {
        return null != t && t == t.window;
    }
    function r(t) {
        return null != t && t.nodeType == t.DOCUMENT_NODE;
    }
    function i(e) {
        return "object" == t(e);
    }
    function o(t) {
        return i(t) && !n(t) && Object.getPrototypeOf(t) == Object.prototype;
    }
    function a(t) {
        return "number" == typeof t.length;
    }
    function s(t) {
        return P.call(t, function(t) {
            return null != t;
        });
    }
    function c(t) {
        return t.length > 0 ? E.fn.concat.apply([], t) : t;
    }
    function u(t) {
        return t.replace(/::/g, "/").replace(/([A-Z]+)([A-Z][a-z])/g, "$1_$2").replace(/([a-z\d])([A-Z])/g, "$1_$2").replace(/_/g, "-").toLowerCase();
    }
    function l(t) {
        return t in R ? R[t] : R[t] = new RegExp("(^|\\s)" + t + "(\\s|$)");
    }
    function f(t, e) {
        return "number" != typeof e || k[u(t)] ? e : e + "px";
    }
    function p(t) {
        var e, n;
        return M[t] || (e = L.createElement(t), L.body.appendChild(e), n = getComputedStyle(e, "").getPropertyValue("display"), 
        e.parentNode.removeChild(e), "none" == n && (n = "block"), M[t] = n), M[t];
    }
    function h(t) {
        return "children" in t ? N.call(t.children) : E.map(t.childNodes, function(t) {
            return 1 == t.nodeType ? t : void 0;
        });
    }
    function d(t, e) {
        var n, r = t ? t.length : 0;
        for (n = 0; r > n; n++) this[n] = t[n];
        this.length = r, this.selector = e || "";
    }
    function m(t, e, n) {
        for (_ in e) n && (o(e[_]) || Q(e[_])) ? (o(e[_]) && !o(t[_]) && (t[_] = {}), Q(e[_]) && !Q(t[_]) && (t[_] = []), 
        m(t[_], e[_], n)) : e[_] !== S && (t[_] = e[_]);
    }
    function g(t, e) {
        return null == e ? E(t) : E(t).filter(e);
    }
    function v(t, n, r, i) {
        return e(n) ? n.call(t, r, i) : n;
    }
    function y(t, e, n) {
        null == n ? t.removeAttribute(e) : t.setAttribute(e, n);
    }
    function w(t, e) {
        var n = t.className || "", r = n && n.baseVal !== S;
        return e === S ? r ? n.baseVal : n : void (r ? n.baseVal = e : t.className = e);
    }
    function x(t) {
        try {
            return t ? "true" == t || ("false" == t ? !1 : "null" == t ? null : +t + "" == t ? +t : /^[\[\{]/.test(t) ? E.parseJSON(t) : t) : t;
        } catch (e) {
            return t;
        }
    }
    function b(t, e) {
        e(t);
        for (var n = 0, r = t.childNodes.length; r > n; n++) b(t.childNodes[n], e);
    }
    var S, _, E, T, C, j, A = [], O = A.concat, P = A.filter, N = A.slice, L = window.document, M = {}, R = {}, k = {
        "column-count": 1,
        columns: 1,
        "font-weight": 1,
        "line-height": 1,
        opacity: 1,
        "z-index": 1,
        zoom: 1
    }, D = /^\s*<(\w+|!)[^>]*>/, q = /^<(\w+)\s*\/?>(?:<\/\1>|)$/, F = /<(?!area|br|col|embed|hr|img|input|link|meta|param)(([\w:]+)[^>]*)\/>/gi, $ = /^(?:body|html)$/i, H = /([A-Z])/g, I = [ "val", "css", "html", "text", "data", "width", "height", "offset" ], Z = [ "after", "prepend", "before", "append" ], z = L.createElement("table"), B = L.createElement("tr"), J = {
        tr: L.createElement("tbody"),
        tbody: z,
        thead: z,
        tfoot: z,
        td: B,
        th: B,
        "*": L.createElement("div")
    }, U = /complete|loaded|interactive/, V = /^[\w-]*$/, X = {}, W = X.toString, Y = {}, G = L.createElement("div"), K = {
        tabindex: "tabIndex",
        readonly: "readOnly",
        "for": "htmlFor",
        "class": "className",
        maxlength: "maxLength",
        cellspacing: "cellSpacing",
        cellpadding: "cellPadding",
        rowspan: "rowSpan",
        colspan: "colSpan",
        usemap: "useMap",
        frameborder: "frameBorder",
        contenteditable: "contentEditable"
    }, Q = Array.isArray || function(t) {
        return t instanceof Array;
    };
    return Y.matches = function(t, e) {
        if (!e || !t || 1 !== t.nodeType) return !1;
        var n = t.webkitMatchesSelector || t.mozMatchesSelector || t.oMatchesSelector || t.matchesSelector;
        if (n) return n.call(t, e);
        var r, i = t.parentNode, o = !i;
        return o && (i = G).appendChild(t), r = ~Y.qsa(i, e).indexOf(t), o && G.removeChild(t), 
        r;
    }, C = function(t) {
        return t.replace(/-+(.)?/g, function(t, e) {
            return e ? e.toUpperCase() : "";
        });
    }, j = function(t) {
        return P.call(t, function(e, n) {
            return t.indexOf(e) == n;
        });
    }, Y.fragment = function(t, e, n) {
        var r, i, a;
        return q.test(t) && (r = E(L.createElement(RegExp.$1))), r || (t.replace && (t = t.replace(F, "<$1></$2>")), 
        e === S && (e = D.test(t) && RegExp.$1), e in J || (e = "*"), a = J[e], a.innerHTML = "" + t, 
        r = E.each(N.call(a.childNodes), function() {
            a.removeChild(this);
        })), o(n) && (i = E(r), E.each(n, function(t, e) {
            I.indexOf(t) > -1 ? i[t](e) : i.attr(t, e);
        })), r;
    }, Y.Z = function(t, e) {
        return new d(t, e);
    }, Y.isZ = function(t) {
        return t instanceof Y.Z;
    }, Y.init = function(t, n) {
        var r;
        if (!t) return Y.Z();
        if ("string" == typeof t) if (t = t.trim(), "<" == t[0] && D.test(t)) r = Y.fragment(t, RegExp.$1, n), 
        t = null; else {
            if (n !== S) return E(n).find(t);
            r = Y.qsa(L, t);
        } else {
            if (e(t)) return E(L).ready(t);
            if (Y.isZ(t)) return t;
            if (Q(t)) r = s(t); else if (i(t)) r = [ t ], t = null; else if (D.test(t)) r = Y.fragment(t.trim(), RegExp.$1, n), 
            t = null; else {
                if (n !== S) return E(n).find(t);
                r = Y.qsa(L, t);
            }
        }
        return Y.Z(r, t);
    }, E = function(t, e) {
        return Y.init(t, e);
    }, E.extend = function(t) {
        var e, n = N.call(arguments, 1);
        return "boolean" == typeof t && (e = t, t = n.shift()), n.forEach(function(n) {
            m(t, n, e);
        }), t;
    }, Y.qsa = function(t, e) {
        var n, r = "#" == e[0], i = !r && "." == e[0], o = r || i ? e.slice(1) : e, a = V.test(o);
        return t.getElementById && a && r ? (n = t.getElementById(o)) ? [ n ] : [] : 1 !== t.nodeType && 9 !== t.nodeType && 11 !== t.nodeType ? [] : N.call(a && !r && t.getElementsByClassName ? i ? t.getElementsByClassName(o) : t.getElementsByTagName(e) : t.querySelectorAll(e));
    }, E.contains = L.documentElement.contains ? function(t, e) {
        return t !== e && t.contains(e);
    } : function(t, e) {
        for (;e && (e = e.parentNode); ) if (e === t) return !0;
        return !1;
    }, E.type = t, E.isFunction = e, E.isWindow = n, E.isArray = Q, E.isPlainObject = o, 
    E.isEmptyObject = function(t) {
        var e;
        for (e in t) return !1;
        return !0;
    }, E.inArray = function(t, e, n) {
        return A.indexOf.call(e, t, n);
    }, E.camelCase = C, E.trim = function(t) {
        return null == t ? "" : String.prototype.trim.call(t);
    }, E.uuid = 0, E.support = {}, E.expr = {}, E.noop = function() {}, E.map = function(t, e) {
        var n, r, i, o = [];
        if (a(t)) for (r = 0; r < t.length; r++) n = e(t[r], r), null != n && o.push(n); else for (i in t) n = e(t[i], i), 
        null != n && o.push(n);
        return c(o);
    }, E.each = function(t, e) {
        var n, r;
        if (a(t)) {
            for (n = 0; n < t.length; n++) if (e.call(t[n], n, t[n]) === !1) return t;
        } else for (r in t) if (e.call(t[r], r, t[r]) === !1) return t;
        return t;
    }, E.grep = function(t, e) {
        return P.call(t, e);
    }, window.JSON && (E.parseJSON = JSON.parse), E.each("Boolean Number String Function Array Date RegExp Object Error".split(" "), function(t, e) {
        X["[object " + e + "]"] = e.toLowerCase();
    }), E.fn = {
        constructor: Y.Z,
        length: 0,
        forEach: A.forEach,
        reduce: A.reduce,
        push: A.push,
        sort: A.sort,
        splice: A.splice,
        indexOf: A.indexOf,
        concat: function() {
            var t, e, n = [];
            for (t = 0; t < arguments.length; t++) e = arguments[t], n[t] = Y.isZ(e) ? e.toArray() : e;
            return O.apply(Y.isZ(this) ? this.toArray() : this, n);
        },
        map: function(t) {
            return E(E.map(this, function(e, n) {
                return t.call(e, n, e);
            }));
        },
        slice: function() {
            return E(N.apply(this, arguments));
        },
        ready: function(t) {
            return U.test(L.readyState) && L.body ? t(E) : L.addEventListener("DOMContentLoaded", function() {
                t(E);
            }, !1), this;
        },
        get: function(t) {
            return t === S ? N.call(this) : this[t >= 0 ? t : t + this.length];
        },
        toArray: function() {
            return this.get();
        },
        size: function() {
            return this.length;
        },
        remove: function() {
            return this.each(function() {
                null != this.parentNode && this.parentNode.removeChild(this);
            });
        },
        each: function(t) {
            return A.every.call(this, function(e, n) {
                return t.call(e, n, e) !== !1;
            }), this;
        },
        filter: function(t) {
            return e(t) ? this.not(this.not(t)) : E(P.call(this, function(e) {
                return Y.matches(e, t);
            }));
        },
        add: function(t, e) {
            return E(j(this.concat(E(t, e))));
        },
        is: function(t) {
            return this.length > 0 && Y.matches(this[0], t);
        },
        not: function(t) {
            var n = [];
            if (e(t) && t.call !== S) this.each(function(e) {
                t.call(this, e) || n.push(this);
            }); else {
                var r = "string" == typeof t ? this.filter(t) : a(t) && e(t.item) ? N.call(t) : E(t);
                this.forEach(function(t) {
                    r.indexOf(t) < 0 && n.push(t);
                });
            }
            return E(n);
        },
        has: function(t) {
            return this.filter(function() {
                return i(t) ? E.contains(this, t) : E(this).find(t).size();
            });
        },
        eq: function(t) {
            return -1 === t ? this.slice(t) : this.slice(t, +t + 1);
        },
        first: function() {
            var t = this[0];
            return t && !i(t) ? t : E(t);
        },
        last: function() {
            var t = this[this.length - 1];
            return t && !i(t) ? t : E(t);
        },
        find: function(t) {
            var e, n = this;
            return e = t ? "object" == typeof t ? E(t).filter(function() {
                var t = this;
                return A.some.call(n, function(e) {
                    return E.contains(e, t);
                });
            }) : 1 == this.length ? E(Y.qsa(this[0], t)) : this.map(function() {
                return Y.qsa(this, t);
            }) : E();
        },
        closest: function(t, e) {
            var n = this[0], i = !1;
            for ("object" == typeof t && (i = E(t)); n && !(i ? i.indexOf(n) >= 0 : Y.matches(n, t)); ) n = n !== e && !r(n) && n.parentNode;
            return E(n);
        },
        parents: function(t) {
            for (var e = [], n = this; n.length > 0; ) n = E.map(n, function(t) {
                return (t = t.parentNode) && !r(t) && e.indexOf(t) < 0 ? (e.push(t), t) : void 0;
            });
            return g(e, t);
        },
        parent: function(t) {
            return g(j(this.pluck("parentNode")), t);
        },
        children: function(t) {
            return g(this.map(function() {
                return h(this);
            }), t);
        },
        contents: function() {
            return this.map(function() {
                return this.contentDocument || N.call(this.childNodes);
            });
        },
        siblings: function(t) {
            return g(this.map(function(t, e) {
                return P.call(h(e.parentNode), function(t) {
                    return t !== e;
                });
            }), t);
        },
        empty: function() {
            return this.each(function() {
                this.innerHTML = "";
            });
        },
        pluck: function(t) {
            return E.map(this, function(e) {
                return e[t];
            });
        },
        show: function() {
            return this.each(function() {
                "none" == this.style.display && (this.style.display = ""), "none" == getComputedStyle(this, "").getPropertyValue("display") && (this.style.display = p(this.nodeName));
            });
        },
        replaceWith: function(t) {
            return this.before(t).remove();
        },
        wrap: function(t) {
            var n = e(t);
            if (this[0] && !n) var r = E(t).get(0), i = r.parentNode || this.length > 1;
            return this.each(function(e) {
                E(this).wrapAll(n ? t.call(this, e) : i ? r.cloneNode(!0) : r);
            });
        },
        wrapAll: function(t) {
            if (this[0]) {
                E(this[0]).before(t = E(t));
                for (var e; (e = t.children()).length; ) t = e.first();
                E(t).append(this);
            }
            return this;
        },
        wrapInner: function(t) {
            var n = e(t);
            return this.each(function(e) {
                var r = E(this), i = r.contents(), o = n ? t.call(this, e) : t;
                i.length ? i.wrapAll(o) : r.append(o);
            });
        },
        unwrap: function() {
            return this.parent().each(function() {
                E(this).replaceWith(E(this).children());
            }), this;
        },
        clone: function() {
            return this.map(function() {
                return this.cloneNode(!0);
            });
        },
        hide: function() {
            return this.css("display", "none");
        },
        toggle: function(t) {
            return this.each(function() {
                var e = E(this);
                (t === S ? "none" == e.css("display") : t) ? e.show() : e.hide();
            });
        },
        prev: function(t) {
            return E(this.pluck("previousElementSibling")).filter(t || "*");
        },
        next: function(t) {
            return E(this.pluck("nextElementSibling")).filter(t || "*");
        },
        html: function(t) {
            return 0 in arguments ? this.each(function(e) {
                var n = this.innerHTML;
                E(this).empty().append(v(this, t, e, n));
            }) : 0 in this ? this[0].innerHTML : null;
        },
        text: function(t) {
            return 0 in arguments ? this.each(function(e) {
                var n = v(this, t, e, this.textContent);
                this.textContent = null == n ? "" : "" + n;
            }) : 0 in this ? this[0].textContent : null;
        },
        attr: function(t, e) {
            var n;
            return "string" != typeof t || 1 in arguments ? this.each(function(n) {
                if (1 === this.nodeType) if (i(t)) for (_ in t) y(this, _, t[_]); else y(this, t, v(this, e, n, this.getAttribute(t)));
            }) : this.length && 1 === this[0].nodeType ? !(n = this[0].getAttribute(t)) && t in this[0] ? this[0][t] : n : S;
        },
        removeAttr: function(t) {
            return this.each(function() {
                1 === this.nodeType && t.split(" ").forEach(function(t) {
                    y(this, t);
                }, this);
            });
        },
        prop: function(t, e) {
            return t = K[t] || t, 1 in arguments ? this.each(function(n) {
                this[t] = v(this, e, n, this[t]);
            }) : this[0] && this[0][t];
        },
        data: function(t, e) {
            var n = "data-" + t.replace(H, "-$1").toLowerCase(), r = 1 in arguments ? this.attr(n, e) : this.attr(n);
            return null !== r ? x(r) : S;
        },
        val: function(t) {
            return 0 in arguments ? this.each(function(e) {
                this.value = v(this, t, e, this.value);
            }) : this[0] && (this[0].multiple ? E(this[0]).find("option").filter(function() {
                return this.selected;
            }).pluck("value") : this[0].value);
        },
        offset: function(t) {
            if (t) return this.each(function(e) {
                var n = E(this), r = v(this, t, e, n.offset()), i = n.offsetParent().offset(), o = {
                    top: r.top - i.top,
                    left: r.left - i.left
                };
                "static" == n.css("position") && (o.position = "relative"), n.css(o);
            });
            if (!this.length) return null;
            if (!E.contains(L.documentElement, this[0])) return {
                top: 0,
                left: 0
            };
            var e = this[0].getBoundingClientRect();
            return {
                left: e.left + window.pageXOffset,
                top: e.top + window.pageYOffset,
                width: Math.round(e.width),
                height: Math.round(e.height)
            };
        },
        css: function(e, n) {
            if (arguments.length < 2) {
                var r, i = this[0];
                if (!i) return;
                if (r = getComputedStyle(i, ""), "string" == typeof e) return i.style[C(e)] || r.getPropertyValue(e);
                if (Q(e)) {
                    var o = {};
                    return E.each(e, function(t, e) {
                        o[e] = i.style[C(e)] || r.getPropertyValue(e);
                    }), o;
                }
            }
            var a = "";
            if ("string" == t(e)) n || 0 === n ? a = u(e) + ":" + f(e, n) : this.each(function() {
                this.style.removeProperty(u(e));
            }); else for (_ in e) e[_] || 0 === e[_] ? a += u(_) + ":" + f(_, e[_]) + ";" : this.each(function() {
                this.style.removeProperty(u(_));
            });
            return this.each(function() {
                this.style.cssText += ";" + a;
            });
        },
        index: function(t) {
            return t ? this.indexOf(E(t)[0]) : this.parent().children().indexOf(this[0]);
        },
        hasClass: function(t) {
            return t ? A.some.call(this, function(t) {
                return this.test(w(t));
            }, l(t)) : !1;
        },
        addClass: function(t) {
            return t ? this.each(function(e) {
                if ("className" in this) {
                    T = [];
                    var n = w(this), r = v(this, t, e, n);
                    r.split(/\s+/g).forEach(function(t) {
                        E(this).hasClass(t) || T.push(t);
                    }, this), T.length && w(this, n + (n ? " " : "") + T.join(" "));
                }
            }) : this;
        },
        removeClass: function(t) {
            return this.each(function(e) {
                if ("className" in this) {
                    if (t === S) return w(this, "");
                    T = w(this), v(this, t, e, T).split(/\s+/g).forEach(function(t) {
                        T = T.replace(l(t), " ");
                    }), w(this, T.trim());
                }
            });
        },
        toggleClass: function(t, e) {
            return t ? this.each(function(n) {
                var r = E(this), i = v(this, t, n, w(this));
                i.split(/\s+/g).forEach(function(t) {
                    (e === S ? !r.hasClass(t) : e) ? r.addClass(t) : r.removeClass(t);
                });
            }) : this;
        },
        scrollTop: function(t) {
            if (this.length) {
                var e = "scrollTop" in this[0];
                return t === S ? e ? this[0].scrollTop : this[0].pageYOffset : this.each(e ? function() {
                    this.scrollTop = t;
                } : function() {
                    this.scrollTo(this.scrollX, t);
                });
            }
        },
        scrollLeft: function(t) {
            if (this.length) {
                var e = "scrollLeft" in this[0];
                return t === S ? e ? this[0].scrollLeft : this[0].pageXOffset : this.each(e ? function() {
                    this.scrollLeft = t;
                } : function() {
                    this.scrollTo(t, this.scrollY);
                });
            }
        },
        position: function() {
            if (this.length) {
                var t = this[0], e = this.offsetParent(), n = this.offset(), r = $.test(e[0].nodeName) ? {
                    top: 0,
                    left: 0
                } : e.offset();
                return n.top -= parseFloat(E(t).css("margin-top")) || 0, n.left -= parseFloat(E(t).css("margin-left")) || 0, 
                r.top += parseFloat(E(e[0]).css("border-top-width")) || 0, r.left += parseFloat(E(e[0]).css("border-left-width")) || 0, 
                {
                    top: n.top - r.top,
                    left: n.left - r.left
                };
            }
        },
        offsetParent: function() {
            return this.map(function() {
                for (var t = this.offsetParent || L.body; t && !$.test(t.nodeName) && "static" == E(t).css("position"); ) t = t.offsetParent;
                return t;
            });
        }
    }, E.fn.detach = E.fn.remove, [ "width", "height" ].forEach(function(t) {
        var e = t.replace(/./, function(t) {
            return t[0].toUpperCase();
        });
        E.fn[t] = function(i) {
            var o, a = this[0];
            return i === S ? n(a) ? a["inner" + e] : r(a) ? a.documentElement["scroll" + e] : (o = this.offset()) && o[t] : this.each(function(e) {
                a = E(this), a.css(t, v(this, i, e, a[t]()));
            });
        };
    }), Z.forEach(function(e, n) {
        var r = n % 2;
        E.fn[e] = function() {
            var e, i, o = E.map(arguments, function(n) {
                return e = t(n), "object" == e || "array" == e || null == n ? n : Y.fragment(n);
            }), a = this.length > 1;
            return o.length < 1 ? this : this.each(function(t, e) {
                i = r ? e : e.parentNode, e = 0 == n ? e.nextSibling : 1 == n ? e.firstChild : 2 == n ? e : null;
                var s = E.contains(L.documentElement, i);
                o.forEach(function(t) {
                    if (a) t = t.cloneNode(!0); else if (!i) return E(t).remove();
                    i.insertBefore(t, e), s && b(t, function(t) {
                        null == t.nodeName || "SCRIPT" !== t.nodeName.toUpperCase() || t.type && "text/javascript" !== t.type || t.src || window.eval.call(window, t.innerHTML);
                    });
                });
            });
        }, E.fn[r ? e + "To" : "insert" + (n ? "Before" : "After")] = function(t) {
            return E(t)[e](this), this;
        };
    }), Y.Z.prototype = d.prototype = E.fn, Y.uniq = j, Y.deserializeValue = x, E.zepto = Y, 
    E;
}();

window.Zepto = Zepto, void 0 === window.$ && (window.$ = Zepto), function(t) {
    function e(e, n, r) {
        var i = t.Event(n);
        return t(e).trigger(i, r), !i.isDefaultPrevented();
    }
    function n(t, n, r, i) {
        return t.global ? e(n || y, r, i) : void 0;
    }
    function r(e) {
        e.global && 0 === t.active++ && n(e, null, "ajaxStart");
    }
    function i(e) {
        e.global && !--t.active && n(e, null, "ajaxStop");
    }
    function o(t, e) {
        var r = e.context;
        return e.beforeSend.call(r, t, e) === !1 || n(e, r, "ajaxBeforeSend", [ t, e ]) === !1 ? !1 : void n(e, r, "ajaxSend", [ t, e ]);
    }
    function a(t, e, r, i) {
        var o = r.context, a = "success";
        r.success.call(o, t, a, e), i && i.resolveWith(o, [ t, a, e ]), n(r, o, "ajaxSuccess", [ e, r, t ]), 
        c(a, e, r);
    }
    function s(t, e, r, i, o) {
        var a = i.context;
        i.error.call(a, r, e, t), o && o.rejectWith(a, [ r, e, t ]), n(i, a, "ajaxError", [ r, i, t || e ]), 
        c(e, r, i);
    }
    function c(t, e, r) {
        var o = r.context;
        r.complete.call(o, e, t), n(r, o, "ajaxComplete", [ e, r ]), i(r);
    }
    function u() {}
    function l(t) {
        return t && (t = t.split(";", 2)[0]), t && (t == _ ? "html" : t == S ? "json" : x.test(t) ? "script" : b.test(t) && "xml") || "text";
    }
    function f(t, e) {
        return "" == e ? t : (t + "&" + e).replace(/[&?]{1,2}/, "?");
    }
    function p(e) {
        e.processData && e.data && "string" != t.type(e.data) && (e.data = t.param(e.data, e.traditional)), 
        !e.data || e.type && "GET" != e.type.toUpperCase() || (e.url = f(e.url, e.data), 
        e.data = void 0);
    }
    function h(e, n, r, i) {
        return t.isFunction(n) && (i = r, r = n, n = void 0), t.isFunction(r) || (i = r, 
        r = void 0), {
            url: e,
            data: n,
            success: r,
            dataType: i
        };
    }
    function d(e, n, r, i) {
        var o, a = t.isArray(n), s = t.isPlainObject(n);
        t.each(n, function(n, c) {
            o = t.type(c), i && (n = r ? i : i + "[" + (s || "object" == o || "array" == o ? n : "") + "]"), 
            !i && a ? e.add(c.name, c.value) : "array" == o || !r && "object" == o ? d(e, c, r, n) : e.add(n, c);
        });
    }
    var m, g, v = 0, y = window.document, w = /<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, x = /^(?:text|application)\/javascript/i, b = /^(?:text|application)\/xml/i, S = "application/json", _ = "text/html", E = /^\s*$/, T = y.createElement("a");
    T.href = window.location.href, t.active = 0, t.ajaxJSONP = function(e, n) {
        if (!("type" in e)) return t.ajax(e);
        var r, i, c = e.jsonpCallback, u = (t.isFunction(c) ? c() : c) || "jsonp" + ++v, l = y.createElement("script"), f = window[u], p = function(e) {
            t(l).triggerHandler("error", e || "abort");
        }, h = {
            abort: p
        };
        return n && n.promise(h), t(l).on("load error", function(o, c) {
            clearTimeout(i), t(l).off().remove(), "error" != o.type && r ? a(r[0], h, e, n) : s(null, c || "error", h, e, n), 
            window[u] = f, r && t.isFunction(f) && f(r[0]), f = r = void 0;
        }), o(h, e) === !1 ? (p("abort"), h) : (window[u] = function() {
            r = arguments;
        }, l.src = e.url.replace(/\?(.+)=\?/, "?$1=" + u), y.head.appendChild(l), e.timeout > 0 && (i = setTimeout(function() {
            p("timeout");
        }, e.timeout)), h);
    }, t.ajaxSettings = {
        type: "GET",
        beforeSend: u,
        success: u,
        error: u,
        complete: u,
        context: null,
        global: !0,
        xhr: function() {
            return new window.XMLHttpRequest();
        },
        accepts: {
            script: "text/javascript, application/javascript, application/x-javascript",
            json: S,
            xml: "application/xml, text/xml",
            html: _,
            text: "text/plain"
        },
        crossDomain: !1,
        timeout: 0,
        processData: !0,
        cache: !0
    }, t.ajax = function(e) {
        var n, i, c = t.extend({}, e || {}), h = t.Deferred && t.Deferred();
        for (m in t.ajaxSettings) void 0 === c[m] && (c[m] = t.ajaxSettings[m]);
        r(c), c.crossDomain || (n = y.createElement("a"), n.href = c.url, n.href = n.href, 
        c.crossDomain = T.protocol + "//" + T.host != n.protocol + "//" + n.host), c.url || (c.url = window.location.toString()), 
        (i = c.url.indexOf("#")) > -1 && (c.url = c.url.slice(0, i)), p(c);
        var d = c.dataType, v = /\?.+=\?/.test(c.url);
        if (v && (d = "jsonp"), c.cache !== !1 && (e && e.cache === !0 || "script" != d && "jsonp" != d) || (c.url = f(c.url, "_=" + Date.now())), 
        "jsonp" == d) return v || (c.url = f(c.url, c.jsonp ? c.jsonp + "=?" : c.jsonp === !1 ? "" : "callback=?")), 
        t.ajaxJSONP(c, h);
        var w, x = c.accepts[d], b = {}, S = function(t, e) {
            b[t.toLowerCase()] = [ t, e ];
        }, _ = /^([\w-]+:)\/\//.test(c.url) ? RegExp.$1 : window.location.protocol, C = c.xhr(), j = C.setRequestHeader;
        if (h && h.promise(C), c.crossDomain || S("X-Requested-With", "XMLHttpRequest"), 
        S("Accept", x || "*/*"), (x = c.mimeType || x) && (x.indexOf(",") > -1 && (x = x.split(",", 2)[0]), 
        C.overrideMimeType && C.overrideMimeType(x)), (c.contentType || c.contentType !== !1 && c.data && "GET" != c.type.toUpperCase()) && S("Content-Type", c.contentType || "application/x-www-form-urlencoded"), 
        c.headers) for (g in c.headers) S(g, c.headers[g]);
        if (C.setRequestHeader = S, C.onreadystatechange = function() {
            if (4 == C.readyState) {
                C.onreadystatechange = u, clearTimeout(w);
                var e, n = !1;
                if (C.status >= 200 && C.status < 300 || 304 == C.status || 0 == C.status && "file:" == _) {
                    d = d || l(c.mimeType || C.getResponseHeader("content-type")), e = C.responseText;
                    try {
                        "script" == d ? (1, eval)(e) : "xml" == d ? e = C.responseXML : "json" == d && (e = E.test(e) ? null : t.parseJSON(e));
                    } catch (r) {
                        n = r;
                    }
                    n ? s(n, "parsererror", C, c, h) : a(e, C, c, h);
                } else s(C.statusText || null, C.status ? "error" : "abort", C, c, h);
            }
        }, o(C, c) === !1) return C.abort(), s(null, "abort", C, c, h), C;
        if (c.xhrFields) for (g in c.xhrFields) C[g] = c.xhrFields[g];
        var A = "async" in c ? c.async : !0;
        C.open(c.type, c.url, A, c.username, c.password);
        for (g in b) j.apply(C, b[g]);
        return c.timeout > 0 && (w = setTimeout(function() {
            C.onreadystatechange = u, C.abort(), s(null, "timeout", C, c, h);
        }, c.timeout)), C.send(c.data ? c.data : null), C;
    }, t.get = function() {
        return t.ajax(h.apply(null, arguments));
    }, t.post = function() {
        var e = h.apply(null, arguments);
        return e.type = "POST", t.ajax(e);
    }, t.getJSON = function() {
        var e = h.apply(null, arguments);
        return e.dataType = "json", t.ajax(e);
    }, t.fn.load = function(e, n, r) {
        if (!this.length) return this;
        var i, o = this, a = e.split(/\s/), s = h(e, n, r), c = s.success;
        return a.length > 1 && (s.url = a[0], i = a[1]), s.success = function(e) {
            o.html(i ? t("<div>").html(e.replace(w, "")).find(i) : e), c && c.apply(o, arguments);
        }, t.ajax(s), this;
    };
    var C = encodeURIComponent;
    t.param = function(e, n) {
        var r = [];
        return r.add = function(e, n) {
            t.isFunction(n) && (n = n()), null == n && (n = ""), this.push(C(e) + "=" + C(n));
        }, d(r, e, n), r.join("&").replace(/%20/g, "+");
    };
}(Zepto), function(t) {
    function e(t) {
        return t._zid || (t._zid = p++);
    }
    function n(t, n, o, a) {
        if (n = r(n), n.ns) var s = i(n.ns);
        return (g[e(t)] || []).filter(function(t) {
            return !(!t || n.e && t.e != n.e || n.ns && !s.test(t.ns) || o && e(t.fn) !== e(o) || a && t.sel != a);
        });
    }
    function r(t) {
        var e = ("" + t).split(".");
        return {
            e: e[0],
            ns: e.slice(1).sort().join(" ")
        };
    }
    function i(t) {
        return new RegExp("(?:^| )" + t.replace(" ", " .* ?") + "(?: |$)");
    }
    function o(t, e) {
        return t.del && !y && t.e in w || !!e;
    }
    function a(t) {
        return x[t] || y && w[t] || t;
    }
    function s(n, i, s, c, l, p, h) {
        var d = e(n), m = g[d] || (g[d] = []);
        i.split(/\s/).forEach(function(e) {
            if ("ready" == e) return t(document).ready(s);
            var i = r(e);
            i.fn = s, i.sel = l, i.e in x && (s = function(e) {
                var n = e.relatedTarget;
                return !n || n !== this && !t.contains(this, n) ? i.fn.apply(this, arguments) : void 0;
            }), i.del = p;
            var d = p || s;
            i.proxy = function(t) {
                if (t = u(t), !t.isImmediatePropagationStopped()) {
                    t.data = c;
                    var e = d.apply(n, t._args == f ? [ t ] : [ t ].concat(t._args));
                    return e === !1 && (t.preventDefault(), t.stopPropagation()), e;
                }
            }, i.i = m.length, m.push(i), "addEventListener" in n && n.addEventListener(a(i.e), i.proxy, o(i, h));
        });
    }
    function c(t, r, i, s, c) {
        var u = e(t);
        (r || "").split(/\s/).forEach(function(e) {
            n(t, e, i, s).forEach(function(e) {
                delete g[u][e.i], "removeEventListener" in t && t.removeEventListener(a(e.e), e.proxy, o(e, c));
            });
        });
    }
    function u(e, n) {
        return (n || !e.isDefaultPrevented) && (n || (n = e), t.each(E, function(t, r) {
            var i = n[t];
            e[t] = function() {
                return this[r] = b, i && i.apply(n, arguments);
            }, e[r] = S;
        }), (n.defaultPrevented !== f ? n.defaultPrevented : "returnValue" in n ? n.returnValue === !1 : n.getPreventDefault && n.getPreventDefault()) && (e.isDefaultPrevented = b)), 
        e;
    }
    function l(t) {
        var e, n = {
            originalEvent: t
        };
        for (e in t) _.test(e) || t[e] === f || (n[e] = t[e]);
        return u(n, t);
    }
    var f, p = 1, h = Array.prototype.slice, d = t.isFunction, m = function(t) {
        return "string" == typeof t;
    }, g = {}, v = {}, y = "onfocusin" in window, w = {
        focus: "focusin",
        blur: "focusout"
    }, x = {
        mouseenter: "mouseover",
        mouseleave: "mouseout"
    };
    v.click = v.mousedown = v.mouseup = v.mousemove = "MouseEvents", t.event = {
        add: s,
        remove: c
    }, t.proxy = function(n, r) {
        var i = 2 in arguments && h.call(arguments, 2);
        if (d(n)) {
            var o = function() {
                return n.apply(r, i ? i.concat(h.call(arguments)) : arguments);
            };
            return o._zid = e(n), o;
        }
        if (m(r)) return i ? (i.unshift(n[r], n), t.proxy.apply(null, i)) : t.proxy(n[r], n);
        throw new TypeError("expected function");
    }, t.fn.bind = function(t, e, n) {
        return this.on(t, e, n);
    }, t.fn.unbind = function(t, e) {
        return this.off(t, e);
    }, t.fn.one = function(t, e, n, r) {
        return this.on(t, e, n, r, 1);
    };
    var b = function() {
        return !0;
    }, S = function() {
        return !1;
    }, _ = /^([A-Z]|returnValue$|layer[XY]$)/, E = {
        preventDefault: "isDefaultPrevented",
        stopImmediatePropagation: "isImmediatePropagationStopped",
        stopPropagation: "isPropagationStopped"
    };
    t.fn.delegate = function(t, e, n) {
        return this.on(e, t, n);
    }, t.fn.undelegate = function(t, e, n) {
        return this.off(e, t, n);
    }, t.fn.live = function(e, n) {
        return t(document.body).delegate(this.selector, e, n), this;
    }, t.fn.die = function(e, n) {
        return t(document.body).undelegate(this.selector, e, n), this;
    }, t.fn.on = function(e, n, r, i, o) {
        var a, u, p = this;
        return e && !m(e) ? (t.each(e, function(t, e) {
            p.on(t, n, r, e, o);
        }), p) : (m(n) || d(i) || i === !1 || (i = r, r = n, n = f), (i === f || r === !1) && (i = r, 
        r = f), i === !1 && (i = S), p.each(function(f, p) {
            o && (a = function(t) {
                return c(p, t.type, i), i.apply(this, arguments);
            }), n && (u = function(e) {
                var r, o = t(e.target).closest(n, p).get(0);
                return o && o !== p ? (r = t.extend(l(e), {
                    currentTarget: o,
                    liveFired: p
                }), (a || i).apply(o, [ r ].concat(h.call(arguments, 1)))) : void 0;
            }), s(p, e, i, r, n, u || a);
        }));
    }, t.fn.off = function(e, n, r) {
        var i = this;
        return e && !m(e) ? (t.each(e, function(t, e) {
            i.off(t, n, e);
        }), i) : (m(n) || d(r) || r === !1 || (r = n, n = f), r === !1 && (r = S), i.each(function() {
            c(this, e, r, n);
        }));
    }, t.fn.trigger = function(e, n) {
        return e = m(e) || t.isPlainObject(e) ? t.Event(e) : u(e), e._args = n, this.each(function() {
            e.type in w && "function" == typeof this[e.type] ? this[e.type]() : "dispatchEvent" in this ? this.dispatchEvent(e) : t(this).triggerHandler(e, n);
        });
    }, t.fn.triggerHandler = function(e, r) {
        var i, o;
        return this.each(function(a, s) {
            i = l(m(e) ? t.Event(e) : e), i._args = r, i.target = s, t.each(n(s, e.type || e), function(t, e) {
                return o = e.proxy(i), i.isImmediatePropagationStopped() ? !1 : void 0;
            });
        }), o;
    }, "focusin focusout focus blur load resize scroll unload click dblclick mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave change select keydown keypress keyup error".split(" ").forEach(function(e) {
        t.fn[e] = function(t) {
            return 0 in arguments ? this.bind(e, t) : this.trigger(e);
        };
    }), t.Event = function(t, e) {
        m(t) || (e = t, t = e.type);
        var n = document.createEvent(v[t] || "Events"), r = !0;
        if (e) for (var i in e) "bubbles" == i ? r = !!e[i] : n[i] = e[i];
        return n.initEvent(t, r, !0), u(n);
    };
}(Zepto), function(t) {
    function e(t, e, n, r) {
        return Math.abs(t - e) >= Math.abs(n - r) ? t - e > 0 ? "Left" : "Right" : n - r > 0 ? "Up" : "Down";
    }
    function n() {
        l = null, p.last && (p.el && p.el.trigger("longTap"), p = {});
    }
    function r() {
        l && clearTimeout(l), l = null;
    }
    function i() {
        s && clearTimeout(s), c && clearTimeout(c), u && clearTimeout(u), l && clearTimeout(l), 
        s = c = u = l = null, p = {};
    }
    function o(t) {
        return ("touch" == t.pointerType || t.pointerType == t.MSPOINTER_TYPE_TOUCH) && t.isPrimary;
    }
    function a(t, e) {
        return t.type == "pointer" + e || t.type.toLowerCase() == "mspointer" + e;
    }
    var s, c, u, l, f, p = {}, h = 750;
    t(document).ready(function() {
        var d, m, g, v, y = 0, w = 0;
        "MSGesture" in window && (f = new MSGesture(), f.target = document.body), t(document).bind("MSGestureEnd", function(t) {
            var e = t.velocityX > 1 ? "Right" : t.velocityX < -1 ? "Left" : t.velocityY > 1 ? "Down" : t.velocityY < -1 ? "Up" : null;
            e && (p.el && p.el.trigger("swipe"), p.el && p.el.trigger("swipe" + e));
        }).on("touchstart MSPointerDown pointerdown", function(e) {
            (!(v = a(e, "down")) || o(e)) && (g = v ? e : e.touches[0], e.touches && 1 === e.touches.length && p.x2 && (p.x2 = void 0, 
            p.y2 = void 0), d = Date.now(), m = d - (p.last || d), p.el = t("tagName" in g.target ? g.target : g.target.parentNode), 
            s && clearTimeout(s), p.x1 = g.pageX, p.y1 = g.pageY, m > 0 && 250 >= m && (p.isDoubleTap = !0), 
            p.last = d, l = setTimeout(n, h), f && v && f.addPointer(e.pointerId));
        }).on("touchmove MSPointerMove pointermove", function(t) {
            (!(v = a(t, "move")) || o(t)) && (g = v ? t : t.touches[0], r(), p.x2 = g.pageX, 
            p.y2 = g.pageY, y += Math.abs(p.x1 - p.x2), w += Math.abs(p.y1 - p.y2));
        }).on("touchend MSPointerUp pointerup", function(n) {
            (!(v = a(n, "up")) || o(n)) && (r(), p.x2 && Math.abs(p.x1 - p.x2) > 30 || p.y2 && Math.abs(p.y1 - p.y2) > 30 ? u = setTimeout(function() {
                p.el && p.el.trigger("swipe"), p.el && p.el.trigger("swipe" + e(p.x1, p.x2, p.y1, p.y2)), 
                p = {};
            }, 0) : "last" in p && (30 > y && 30 > w ? c = setTimeout(function() {
                var e = t.Event("tap");
                e.cancelTouch = i, p.el && p.el.trigger(e), p.isDoubleTap ? (p.el && p.el.trigger("doubleTap"), 
                p = {}) : s = setTimeout(function() {
                    s = null, p.el && p.el.trigger("singleTap"), p = {};
                }, 250);
            }, 0) : p = {}), y = w = 0);
        }).on("touchcancel MSPointerCancel pointercancel", i), t(window).on("scroll", i);
    }), [ "swipe", "swipeLeft", "swipeRight", "swipeUp", "swipeDown", "doubleTap", "tap", "singleTap", "longTap" ].forEach(function(e) {
        t.fn[e] = function(t) {
            return this.on(e, t);
        };
    });
}(Zepto), !function() {
    function t(t) {
        if (void 0 === t) return t;
        var e, n, r, i, o, a;
        for (r = t.length, n = 0, e = ""; r > n; ) {
            if (i = 255 & t.charCodeAt(n++), n == r) {
                e += d.charAt(i >> 2), e += d.charAt((3 & i) << 4), e += "==";
                break;
            }
            if (o = t.charCodeAt(n++), n == r) {
                e += d.charAt(i >> 2), e += d.charAt((3 & i) << 4 | (240 & o) >> 4), e += d.charAt((15 & o) << 2), 
                e += "=";
                break;
            }
            a = t.charCodeAt(n++), e += d.charAt(i >> 2), e += d.charAt((3 & i) << 4 | (240 & o) >> 4), 
            e += d.charAt((15 & o) << 2 | (192 & a) >> 6), e += d.charAt(63 & a);
        }
        return e;
    }
    function e(t) {
        for (var e in t) return !1;
        return !0;
    }
    function n(t, n) {
        var r = 100;
        if ("share" == t) {
            if (n && !e(n)) return n;
            var i = "", o = "", a = "", s = document.querySelector("title"), c = document.querySelector("meta[name=description]"), u = document.querySelector("link[rel*=apple-touch-icon]"), l = document.querySelector("link[rel*=shortcut]");
            if (s && (i = s.innerText), c && (o = c.content), l && (a = l.href), u && (a = u.href), 
            !a) for (var f = document.querySelectorAll("body img"), p = 0; p < f.length; p++) {
                var h = f[p];
                if (h.naturalWidth > r && h.naturalHeight > r) {
                    a = h.src;
                    break;
                }
            }
            return {
                platform: "weixin_moments",
                url: location.href,
                title: i,
                desc: o,
                image: a
            };
        }
        return n;
    }
    function r() {
        p = document.createElement("iframe"), p.id = "__ToutiaoJSBridgeIframe_SetResult", 
        p.style.display = "none", document.documentElement.appendChild(p), f = document.createElement("iframe"), 
        f.id = "__ToutiaoJSBridgeIframe", f.style.display = "none", document.documentElement.appendChild(f);
    }
    function i() {
        var t = JSON.stringify(m);
        return m = [], a("SCENE_FETCHQUEUE", t), t;
    }
    function o(t) {
        var e, n = t.__msg_type, r = t.__params, i = t.__event_id, o = t.__callback_id;
        return "callback" == n ? (e = {
            __err_code: "cb404"
        }, "string" == typeof o && "function" == typeof v[o] && (e = v[o](r), delete v[o])) : "event" == n && (e = {
            __err_code: "ev404"
        }, "string" == typeof i && "function" == typeof y[i] && (e = y[i](r))), a("SCENE_HANDLEMSGFROMTT", JSON.stringify(e)), 
        JSON.stringify(e);
    }
    function a(e, n) {
        p.src = w + "private/setresult/" + e + "&" + t(h.encode(n));
    }
    function s(t, e, r, i) {
        if (i = i || 1, t && "string" == typeof t) {
            "object" != typeof e && (e = {}), e = n(t, e);
            var o = (g++).toString();
            "function" == typeof r && (v[o] = r);
            var a = {
                JSSDK: i,
                func: t,
                params: e,
                __msg_type: "call",
                __callback_id: o
            };
            m.push(a), f.src = w + "dispatch_message/";
        }
    }
    function c(t, e) {
        t && "string" == typeof t && "function" == typeof e && (y[t] = e, s("addEventListener", {
            name: t
        }, null));
    }
    function u(t, e) {
        "function" == typeof y[t] && y[t](e);
    }
    function l() {
        function t(t, e) {
            return "params" == e ? t : t[e];
        }
        var n = {
            pageStateChange: "page_state_change",
            isVisible: "is_visible",
            isLogin: "is_login",
            uploadImage: "upload_image"
        }, r = [ "appInfo", "login", "comment", "close", "isVisible", "isLogin", "playVideo" ], i = [ "isAppInstalled", "open", "share", "systemShare", "pay", "pageStateChange", "downloadApp", "openThirdApp", "uploadImage", "addChannel", "gallery", "copyToClipboard", "openCocosPlay" ], o = r.concat(i), a = navigator.userAgent.match(/JSSDK\/([\d.]+)/i), c = a ? a[1] : 1;
        a ? o = o.concat([ "config" ]) : toutiao.config = function(e) {
            var n = t(e, "success");
            return n ? n({
                code: 1,
                supportList: {
                    call: r
                }
            }) : void 0;
        }, o.forEach(function(r) {
            toutiao[r] = function(i) {
                i = i || {};
                var o = t(i, "params"), a = t(i, "error"), u = t(i, "success"), l = t(i, "fail");
                r = n[r] || r, s(r, o, function(t) {
                    t = t || {};
                    var n = t.code;
                    e(t) ? n = 1 : void 0 == n && (n = 1), -1 == n && a && a(t), 0 == n && l && l(t), 
                    1 == n && u && u(t);
                }, c);
            };
        });
    }
    var f, p, h = {
        encode: function(t) {
            t = t || "", t = t.replace(/\r\n/g, "\n");
            for (var e = "", n = 0; n < t.length; n++) {
                var r = t.charCodeAt(n);
                128 > r ? e += String.fromCharCode(r) : r > 127 && 2048 > r ? (e += String.fromCharCode(r >> 6 | 192), 
                e += String.fromCharCode(63 & r | 128)) : (e += String.fromCharCode(r >> 12 | 224), 
                e += String.fromCharCode(r >> 6 & 63 | 128), e += String.fromCharCode(63 & r | 128));
            }
            return e;
        },
        decode: function(t) {
            for (var e = "", n = 0, r = c1 = c2 = 0; n < t.length; ) r = t.charCodeAt(n), 128 > r ? (e += String.fromCharCode(r), 
            n++) : r > 191 && 224 > r ? (c2 = t.charCodeAt(n + 1), e += String.fromCharCode((31 & r) << 6 | 63 & c2), 
            n += 2) : (c2 = t.charCodeAt(n + 1), c3 = t.charCodeAt(n + 2), e += String.fromCharCode((15 & r) << 12 | (63 & c2) << 6 | 63 & c3), 
            n += 3);
            return e;
        }
    }, d = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", m = [], g = 1e3, v = {}, y = {}, w = "bytedance://";
    window.ToutiaoJSBridge = {
        call: s,
        on: c,
        _fetchQueue: i,
        _handleMessageFromToutiao: o
    }, window.toutiao = {
        on: c,
        trigger: u
    }, r(), l();
}(), !function(t, e) {
    "object" == typeof exports && "object" == typeof module ? module.exports = e() : "function" == typeof define && define.amd ? define([], e) : "object" == typeof exports ? exports.Slardar = e() : t.Slardar = e();
}("undefined" != typeof self ? self : this, function() {
    return function(t) {
        function e(r) {
            if (n[r]) return n[r].exports;
            var i = n[r] = {
                i: r,
                l: !1,
                exports: {}
            };
            return t[r].call(i.exports, i, i.exports, e), i.l = !0, i.exports;
        }
        var n = {};
        return e.m = t, e.c = n, e.d = function(t, n, r) {
            e.o(t, n) || Object.defineProperty(t, n, {
                configurable: !1,
                enumerable: !0,
                get: r
            });
        }, e.n = function(t) {
            var n = t && t.__esModule ? function() {
                return t.default;
            } : function() {
                return t;
            };
            return e.d(n, "a", n), n;
        }, e.o = function(t, e) {
            return Object.prototype.hasOwnProperty.call(t, e);
        }, e.p = "", e(e.s = 1);
    }([ function(t) {
        function e(t) {
            return "object" == typeof t && null !== t;
        }
        function n(t) {
            return "function" == typeof t;
        }
        function r(t) {
            return "[object String]" === Object.prototype.toString.call(t);
        }
        function i(t) {
            return "[object Array]" === Object.prototype.toString.call(t);
        }
        function o(t) {
            return "[object Date]" === Object.prototype.toString.call(t);
        }
        function a(t) {
            return void 0 === t;
        }
        function s(t, e) {
            return Object.prototype.hasOwnProperty.call(t, e);
        }
        function c(t, e) {
            var n, r;
            if (a(t.length)) for (n in t) s(t, n) && e.call(null, n, t[n]); else if (r = t.length) for (n = 0; r > n; n++) e.call(null, n, t[n]);
        }
        function u(t) {
            for (var e in t) if (t.hasOwnProperty(e)) return !1;
            return !0;
        }
        function l(t) {
            for (var e, n = [], i = 0, o = t.length; o > i; i++) e = t[i], r(e) ? n.push(e.replace(/([.*+?^=!:${}()|\[\]\/\\])/g, "\\$1")) : e && e.source && n.push(e.source);
            return new RegExp(n.join("|"), "i");
        }
        function f(t) {
            var e = document.createElement("a");
            e.href = t;
            var n = e.pathname || "/";
            return "/" !== n[0] && (n = "/" + n), {
                protocol: e.protocol.slice(0, -1),
                hostname: e.hostname,
                pathname: n
            };
        }
        function p(t) {
            var e = [];
            return c(t, function(t, n) {
                e.push(encodeURIComponent(t) + "=" + encodeURIComponent(n));
            }), e.join("&");
        }
        function h() {
            return +new Date();
        }
        function d(t) {
            var e = t.offsetTop;
            return null !== t.offsetParent && (e += d(t.offsetParent)), e;
        }
        function m() {
            return window.innerHeight ? window.innerHeight : document.documentElement && document.documentElement.clientHeight ? document.documentElement.clientHeight : void 0;
        }
        t.exports = {
            isObject: e,
            isFunction: n,
            isString: r,
            isArray: i,
            isDate: o,
            each: c,
            isEmptyObject: u,
            joinRegExp: l,
            urlParser: f,
            urlencode: p,
            now: h,
            getOffsetTop: d,
            getWinHeight: m
        };
    }, function(t, e, n) {
        t.exports = n(2);
    }, function(t, e, n) {
        var r = n(3), i = new r();
        t.exports = i;
    }, function(t, e, n) {
        function r() {
            this._baseParams = {}, this._globalOptions = {
                sampleRate: 1,
                ignoreStatic: [],
                ignoreAjax: []
            }, this.recordCtx = {
                __firstScreenLoadEndTime: 0
            };
        }
        var i = n(4), o = n(5), a = n(7), s = n(8), c = n(0), u = c.isObject, l = c.isArray, f = c.each, p = c.isEmptyObject, h = c.urlencode, d = c.joinRegExp, m = c.now;
        r.prototype = {
            VERSION: "1.0.0",
            install: function(t) {
                var e = this, n = e._baseParams, r = e._globalOptions;
                e._baseEnvCheck() && u(t) && !p(t) && t.bid && t.pid && (n.version = this.VERSION, 
                n.bid = t.bid, n.pid = t.pid, n.hostname = window.location.hostname, n.protocol = window.location.protocol.slice(0, -1), 
                r.sampleRate = t.sampleRate || 1, r.ignoreStatic = !(!l(t.ignoreStatic) || !t.ignoreStatic.length) && d(t.ignoreStatic), 
                r.ignoreAjax = !(!l(t.ignoreAjax) || !t.ignoreAjax.length) && d(t.ignoreAjax), o.start(this.recordCtx), 
                a.start(function() {
                    e._send.apply(e, arguments);
                }, this.recordCtx), i.start(function() {
                    e._send.apply(e, arguments);
                }, r.ignoreStatic), s.start(function() {
                    e._send.apply(e, arguments);
                }, r.ignoreAjax));
            },
            sendCustomTimeLog: function(t, e, n) {
                if (t) {
                    var r = {
                        ev_type: "custom",
                        cm_name: t,
                        cm_type: "time"
                    };
                    e && (r.cm_tag = e), +n && (r.cm_value = +n, this._send(r, !0));
                }
            },
            sendCustomCountLog: function(t, e) {
                if (t) {
                    var n = {
                        ev_type: "custom",
                        cm_name: t,
                        cm_type: "count"
                    };
                    e && (n.cm_tag = e), this._send(n);
                }
            },
            _send: function(t, e) {
                var n = this._globalOptions, r = this._paramsPack(t);
                r && ("number" == typeof n.sampleRate ? Math.random() < n.sampleRate && this._makeRequest(r, e) : this._makeRequest(r, e));
            },
            _makeRequest: function(t, e) {
                var n = new Image(), r = e ? "https://m.toutiao.com/log/sentry/v2/api/slardar/custom/?" : "https://m.toutiao.com/log/sentry/v2/api/slardar/main/?";
                n.src = r + t;
            },
            _paramsPack: function(t) {
                return !u(t) || p(t) ? null : (f(this._baseParams, function(e, n) {
                    t[e] = n;
                }), t.timestamp = m(), h(t));
            },
            _baseEnvCheck: function() {
                return !!window.addEventListener;
            }
        }, t.exports = r;
    }, function(t, e, n) {
        var r = n(0), i = r.urlParser, o = {
            start: function(t, e) {
                function n(t, e) {
                    var n = {
                        ev_type: "static",
                        st_type: e
                    }, r = i(t);
                    return n.st_protocol = r.protocol, n.st_domain = r.hostname, n.st_domain ? ("script" !== e && "link" !== e || (n.st_path = r.pathname), 
                    "img" !== e || r.pathname && "/" !== r.pathname ? n : null) : null;
                }
                function r(r) {
                    var i = r || window.event || {}, o = {};
                    try {
                        o = i.target || i.srcElement || {};
                    } catch (i) {
                        return;
                    }
                    var a = o.src || o.href || "", s = o.tagName && o.tagName.toLowerCase() || "";
                    a && s && a !== window.location.href && (e && e.test(a) || t && t(n(a, s)));
                }
                window.addEventListener("error", r, !0);
            }
        };
        t.exports = o;
    }, function(t, e, n) {
        var r = n(0), i = n(6), o = r.getOffsetTop, a = r.getWinHeight, s = r.now, c = i.raf, u = i.caf, l = {
            start: function(t) {
                var e = a(), n = [], r = !1, i = !1, l = c(function f() {
                    var a, p;
                    if (r) {
                        if (n.length && !i) for (a = 0; a < n.length; a++) {
                            if (p = n[a], !p.complete) {
                                i = !1;
                                break;
                            }
                            i = !0;
                        } else i = !0;
                        if (i) return t.__firstScreenLoadEndTime = s(), void u(l);
                    } else {
                        var h = document.querySelectorAll("img");
                        for (a = 0; a < h.length; a++) {
                            p = h[a];
                            var d = o(p);
                            if (d > e) {
                                r = !0;
                                break;
                            }
                            e >= d && !p.hasPushed && (p.hasPushed = 1, n.push(p));
                        }
                    }
                    l = c(f);
                });
                document.addEventListener("DOMContentLoaded", function() {
                    document.querySelectorAll("img").length || (r = !0);
                }), window.addEventListener("load", function() {
                    i = !0, r = !0;
                }, !1);
            }
        };
        t.exports = l;
    }, function(t) {
        for (var e = 0, n = [ "ms", "moz", "webkit", "o" ], r = window.requestAnimationFrame, i = window.cancelAnimationFrame, o = 0; o < n.length && !r; ++o) r = window[n[o] + "RequestAnimationFrame"], 
        i = window[n[o] + "CancelAnimationFrame"] || window[n[o] + "CancelRequestAnimationFrame"];
        r || (r = function(t) {
            var n = new Date().getTime(), r = Math.max(0, 16 - (n - e)), i = window.setTimeout(function() {
                t(n + r);
            }, r);
            return e = n + r, i;
        }), i || (i = function(t) {
            clearTimeout(t);
        }), t.exports = {
            raf: r,
            caf: i
        };
    }, function(t, e, n) {
        var r = n(0), i = r.isObject, o = window.performance, a = {
            start: function(t, e) {
                function n() {
                    var t = {
                        ev_type: "perf"
                    }, n = o.timing;
                    return t.dns = n.domainLookupEnd - n.domainLookupStart, t.tcp = n.connectEnd - n.connectStart, 
                    t.request = n.responseStart - n.requestStart, t.response = n.responseEnd - n.responseStart, 
                    t.processing = n.domComplete - n.domLoading, t.blank = n.responseEnd - n.navigationStart, 
                    t.domready = n.domInteractive - n.navigationStart, t.load = n.loadEventEnd - n.navigationStart, 
                    t.firstscreen = e.__firstScreenLoadEndTime ? e.__firstScreenLoadEndTime - n.navigationStart : t.domready, 
                    t;
                }
                function r() {
                    t && t(n());
                }
                i(o) && window.addEventListener("load", function() {
                    setTimeout(r, 1500);
                }, !1);
            }
        };
        t.exports = a;
    }, function(t, e, n) {
        var r = n(0), i = r.urlParser, o = r.now, a = /m\.toutiao\.com\/log\/sentry\/v2\/api\/(\d+)\/store\/$/, s = window.XMLHttpRequest, c = {
            start: function(t, e) {
                function n(n, r) {
                    if (!(e && e.test(r) || a.test(r) || 0 === n.ax_status)) {
                        var o = i(r);
                        n.ax_protocol = o.protocol, n.ax_domain = o.hostname, n.ax_path = o.pathname, n.ax_domain && t && t(n);
                    }
                }
                function r(t) {
                    var e = "[object String]" === Object.prototype.toString.call(t);
                    return t ? e ? t.length : window.ArrayBuffer && t instanceof ArrayBuffer ? t.byteLength : window.Blob && t instanceof Blob ? t.size : t.length ? t.length : 0 : 0;
                }
                function c(t, e) {
                    return this._url = e && e.split("?")[0] || "", this._method = t && t.toLowerCase() || "", 
                    f.apply(this, arguments);
                }
                function u() {
                    if (4 === this.readyState) {
                        var t = {
                            ev_type: "ajax",
                            ax_status: this.status,
                            ax_type: this._method
                        };
                        if (200 === this.status) if (t.ax_duration = o() - this._start, "" === this.responseType || "text" === this.responseType) t.ax_size = r(this.responseText); else if (this.response) t.ax_size = r(this.response); else try {
                            t.ax_size = r(this.responseText);
                        } catch (e) {}
                        n(t, this._url);
                    }
                    return this._onreadystatechange ? this._onreadystatechange.apply(this, arguments) : void 0;
                }
                function l() {
                    return this.onreadystatechange && (this._onreadystatechange = this.onreadystatechange), 
                    this.onreadystatechange = u, this._start = o(), p.apply(this, arguments);
                }
                if ("function" == typeof s) {
                    var f = s.prototype.open, p = s.prototype.send;
                    s.prototype.open = c, s.prototype.send = l;
                }
            }
        };
        t.exports = c;
    } ]);
}), window.Slardar && window.Slardar.install({
    sampleRate: 1,
    bid: "wenda_app_article",
    pid: "wukong_article",
    ignoreAjax: [],
    ignoreStatic: []
});