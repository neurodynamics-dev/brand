/* @ds-bundle: {"format":4,"namespace":"NeuroDynamicsDesignSystem_10bbff","components":[{"name":"Alert","sourcePath":"components/core/Alert.jsx"},{"name":"Button","sourcePath":"components/core/Button.jsx"},{"name":"Card","sourcePath":"components/core/Card.jsx"},{"name":"Chip","sourcePath":"components/core/Chip.jsx"},{"name":"Eyebrow","sourcePath":"components/core/Eyebrow.jsx"},{"name":"IconButton","sourcePath":"components/core/IconButton.jsx"},{"name":"Pill","sourcePath":"components/core/Pill.jsx"},{"name":"Switch","sourcePath":"components/core/Switch.jsx"},{"name":"Tag","sourcePath":"components/core/Tag.jsx"},{"name":"DataTable","sourcePath":"components/formal/DataTable.jsx"},{"name":"Kicker","sourcePath":"components/formal/Kicker.jsx"},{"name":"Letterhead","sourcePath":"components/formal/Letterhead.jsx"},{"name":"SignatureBlock","sourcePath":"components/formal/SignatureBlock.jsx"},{"name":"Band","sourcePath":"components/interface/Band.jsx"},{"name":"BarList","sourcePath":"components/interface/BarList.jsx"},{"name":"Breadcrumb","sourcePath":"components/interface/Breadcrumb.jsx"},{"name":"DataGrid","sourcePath":"components/interface/DataGrid.jsx"},{"name":"Dialog","sourcePath":"components/interface/Dialog.jsx"},{"name":"EmptyState","sourcePath":"components/interface/EmptyState.jsx"},{"name":"Field","sourcePath":"components/interface/Field.jsx"},{"name":"FilterBar","sourcePath":"components/interface/FilterBar.jsx"},{"name":"Metric","sourcePath":"components/interface/Metric.jsx"},{"name":"Progress","sourcePath":"components/interface/Progress.jsx"},{"name":"ProportionBar","sourcePath":"components/interface/ProportionBar.jsx"},{"name":"SectionNav","sourcePath":"components/interface/SectionNav.jsx"},{"name":"Segmented","sourcePath":"components/interface/Segmented.jsx"},{"name":"SideMenu","sourcePath":"components/interface/SideMenu.jsx"},{"name":"SiteHeader","sourcePath":"components/interface/SiteHeader.jsx"},{"name":"Skeleton","sourcePath":"components/interface/Skeleton.jsx"},{"name":"SpecList","sourcePath":"components/interface/SpecList.jsx"},{"name":"Tabs","sourcePath":"components/interface/Tabs.jsx"},{"name":"Toast","sourcePath":"components/interface/Toast.jsx"},{"name":"Widget","sourcePath":"components/interface/Widget.jsx"}],"sourceHashes":{"components/core/Alert.jsx":"c65d680dcb1a","components/core/Button.jsx":"a0958caed7a1","components/core/Card.jsx":"c042dfc8f267","components/core/Chip.jsx":"b90a6a87bb29","components/core/Eyebrow.jsx":"242d2b61e5e1","components/core/IconButton.jsx":"c4403732e3c9","components/core/Pill.jsx":"377e8e65d273","components/core/Switch.jsx":"1289b351d94e","components/core/Tag.jsx":"996b3a30267c","components/formal/DataTable.jsx":"2b97f752d17f","components/formal/Kicker.jsx":"03efbcd281bc","components/formal/Letterhead.jsx":"e61d830e34fd","components/formal/SignatureBlock.jsx":"b089f37c4940","components/interface/Band.jsx":"4c598927c81c","components/interface/BarList.jsx":"72a4aab4bd2b","components/interface/Breadcrumb.jsx":"89ebe72aada1","components/interface/DataGrid.jsx":"ae60f325a143","components/interface/Dialog.jsx":"473969eddca3","components/interface/EmptyState.jsx":"dc01c4a477bf","components/interface/Field.jsx":"9705bb7ead4e","components/interface/FilterBar.jsx":"34e1733077e9","components/interface/Metric.jsx":"d82fae67ce48","components/interface/Progress.jsx":"375d23e15d41","components/interface/ProportionBar.jsx":"47472e11bcd4","components/interface/SectionNav.jsx":"8b811953b879","components/interface/Segmented.jsx":"c947cc67f917","components/interface/SideMenu.jsx":"2716de5a94a1","components/interface/SiteHeader.jsx":"5b88bd2f8670","components/interface/Skeleton.jsx":"7d8403332ab3","components/interface/SpecList.jsx":"28e7aa856bde","components/interface/Tabs.jsx":"c2802e688582","components/interface/Toast.jsx":"777c00da7936","components/interface/Widget.jsx":"eed241846c4e"},"inlinedExternals":[],"unexposedExports":[]} */

(() => {

const __ds_ns = (window.NeuroDynamicsDesignSystem_10bbff = window.NeuroDynamicsDesignSystem_10bbff || {});

const __ds_scope = {};

(__ds_ns.__errors = __ds_ns.__errors || []);

// components/core/Alert.jsx
try { (() => {
const K = {
  nominal: 'nominal',
  caution: 'caution',
  critical: 'critical',
  signal: 'signal',
  idle: 'idle',
  vital: 'nominal',
  mielina: 'caution',
  pulso: 'critical',
  plasma: 'signal',
  ion: 'signal',
  dendrito: 'idle'
};
const IC = {
  nominal: '✓',
  caution: '!',
  critical: '×',
  signal: 'i',
  idle: 'i'
};
function Alert({
  status = 'signal',
  title,
  children
}) {
  const f = K[status] || 'signal',
    c = `var(--fn-${f}-primary)`;
  return /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      gap: 13,
      padding: '15px 18px',
      borderRadius: 'var(--r-md)',
      border: `1px solid color-mix(in srgb, ${c} 35%, transparent)`,
      background: `color-mix(in srgb, ${c} 7%, transparent)`,
      alignItems: 'flex-start'
    }
  }, /*#__PURE__*/React.createElement("span", {
    "aria-hidden": "true",
    style: {
      width: 22,
      height: 22,
      borderRadius: 4,
      flex: 'none',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      fontFamily: 'var(--fm)',
      fontSize: 12,
      fontWeight: 600,
      marginTop: 1,
      background: `color-mix(in srgb, ${c} 16%, transparent)`,
      color: c
    }
  }, IC[f]), /*#__PURE__*/React.createElement("div", null, /*#__PURE__*/React.createElement("b", {
    style: {
      fontFamily: 'var(--fd)',
      fontSize: 13.5,
      display: 'block',
      marginBottom: 2,
      color: 'var(--ink)'
    }
  }, title), /*#__PURE__*/React.createElement("p", {
    style: {
      fontSize: 12.5,
      color: 'var(--nevoa)',
      margin: 0
    }
  }, children)));
}
Object.assign(__ds_scope, { Alert });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/core/Alert.jsx", error: String((e && e.message) || e) }); }

// components/core/Button.jsx
try { (() => {
function _extends() { return _extends = Object.assign ? Object.assign.bind() : function (n) { for (var e = 1; e < arguments.length; e++) { var t = arguments[e]; for (var r in t) ({}).hasOwnProperty.call(t, r) && (n[r] = t[r]); } return n; }, _extends.apply(null, arguments); }
const V = {
  danger: {
    background: 'var(--fn-critical-primary)',
    color: '#FFFFFF'
  },
  solid: {
    background: 'var(--synapse)',
    color: 'var(--cortex)'
  },
  claro: {
    background: 'var(--ink)',
    color: '#0A0F0E'
  },
  ghost: {
    background: 'rgba(255,255,255,.03)',
    border: '1px solid var(--line2)',
    color: 'var(--ink)'
  },
  formal: {
    background: 'var(--cortex)',
    color: '#fff',
    borderRadius: 'var(--r-formal)'
  },
  'formal-outline': {
    background: 'transparent',
    border: '1px solid var(--formal-rule-strong)',
    color: 'var(--formal-ink)',
    borderRadius: 'var(--r-formal)'
  }
};
const HOV = {
  danger: {
    background: '#E0261A'
  },
  solid: {
    transform: 'translateY(-1px)',
    boxShadow: '0 8px 26px rgba(206,220,0,.22)'
  },
  claro: {
    transform: 'translateY(-1px)',
    boxShadow: '0 8px 26px rgba(245,245,247,.14)'
  },
  ghost: {
    background: 'rgba(255,255,255,.07)',
    borderColor: 'var(--grafite)'
  },
  formal: {
    background: 'var(--axon)'
  },
  'formal-outline': {
    background: 'var(--paper-tint)'
  }
};
function Button({
  family,
  variant = 'solid',
  size = 'md',
  disabled = false,
  children,
  style,
  ...rest
}) {
  const [h, setH] = React.useState(false);
  const mini = size === 'mini';
  return /*#__PURE__*/React.createElement("button", _extends({
    disabled: disabled,
    onMouseEnter: () => setH(true),
    onMouseLeave: () => setH(false),
    style: {
      display: 'inline-flex',
      alignItems: 'center',
      justifyContent: 'center',
      gap: 9,
      height: mini ? 34 : 44,
      padding: mini ? '0 13px' : '0 20px',
      borderRadius: mini ? 9 : 'var(--r-sm)',
      fontFamily: 'var(--fd)',
      fontWeight: 600,
      fontSize: mini ? 12 : 14,
      border: 'none',
      cursor: 'pointer',
      whiteSpace: 'nowrap',
      transition: 'transform var(--t-fast),box-shadow var(--t-fast),background var(--t-fast),border-color var(--t-fast)',
      opacity: disabled ? .4 : 1,
      pointerEvents: disabled ? 'none' : 'auto',
      ...(family ? {
        background: 'var(--' + family + '-medium)',
        color: 'var(--' + family + '-dark)'
      } : V[variant]),
      ...(h && !disabled ? family ? {
        background: 'var(--' + family + '-light)',
        transform: 'translateY(-1px)'
      } : HOV[variant] : {}),
      ...style
    }
  }, rest), children);
}
Object.assign(__ds_scope, { Button });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/core/Button.jsx", error: String((e && e.message) || e) }); }

// components/core/Card.jsx
try { (() => {
function Card({
  title,
  children,
  tone = 'dark',
  style
}) {
  const p = tone === 'paper';
  return /*#__PURE__*/React.createElement("div", {
    style: {
      border: '1px solid ' + (p ? 'var(--formal-rule)' : 'var(--line)'),
      borderRadius: p ? 'var(--r-formal)' : 'var(--r)',
      background: p ? 'var(--paper)' : 'var(--card)',
      padding: 24,
      color: p ? 'var(--formal-ink)' : 'var(--ink)',
      ...style
    }
  }, title && /*#__PURE__*/React.createElement("h3", {
    style: {
      fontFamily: 'var(--fd)',
      fontSize: 16,
      fontWeight: 600,
      margin: '0 0 6px',
      letterSpacing: '-.015em'
    }
  }, title), /*#__PURE__*/React.createElement("div", {
    style: {
      fontSize: 13.5,
      color: p ? 'var(--formal-ink-2)' : 'var(--nevoa)',
      lineHeight: 1.65
    }
  }, children));
}
Object.assign(__ds_scope, { Card });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/core/Card.jsx", error: String((e && e.message) || e) }); }

// components/core/Chip.jsx
try { (() => {
function _extends() { return _extends = Object.assign ? Object.assign.bind() : function (n) { for (var e = 1; e < arguments.length; e++) { var t = arguments[e]; for (var r in t) ({}).hasOwnProperty.call(t, r) && (n[r] = t[r]); } return n; }, _extends.apply(null, arguments); }
function Chip({
  on = false,
  variant = 'quiet',
  children,
  style,
  ...rest
}) {
  const [f, setF] = React.useState(false);
  const [h, setH] = React.useState(false);
  const acc = variant === 'accent' && on;
  return /*#__PURE__*/React.createElement("button", _extends({
    "aria-pressed": on,
    onFocus: e => {
      setF(e.target.matches(':focus-visible'));
    },
    onBlur: () => setF(false),
    onMouseEnter: () => setH(true),
    onMouseLeave: () => setH(false),
    style: {
      padding: '4px 11px',
      lineHeight: 1.4,
      borderRadius: 6,
      fontSize: 12,
      fontWeight: on ? 600 : 500,
      fontFamily: 'var(--f)',
      cursor: 'pointer',
      background: acc ? 'var(--synapse)' : on ? 'rgba(255,255,255,.09)' : h ? 'rgba(255,255,255,.05)' : 'rgba(255,255,255,.02)',
      border: '1px solid ' + (acc ? 'var(--synapse)' : on ? 'var(--line2)' : 'var(--line)'),
      color: acc ? 'var(--cortex)' : on || h ? 'var(--ink)' : 'var(--nevoa)',
      outline: f ? '2px solid var(--synapse)' : 'none',
      outlineOffset: 2,
      transition: 'all var(--t-fast)',
      ...style
    }
  }, rest), children);
}
Object.assign(__ds_scope, { Chip });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/core/Chip.jsx", error: String((e && e.message) || e) }); }

// components/core/Eyebrow.jsx
try { (() => {
function Eyebrow({
  children,
  tone = 'dark'
}) {
  const p = tone === 'paper';
  return /*#__PURE__*/React.createElement("span", {
    style: {
      display: 'inline-flex',
      alignItems: 'center',
      gap: 10,
      fontFamily: 'var(--fd)',
      fontWeight: 600,
      fontSize: p ? 10 : 11.5,
      letterSpacing: '.14em',
      textTransform: 'uppercase',
      color: 'var(--nevoa)'
    }
  }, /*#__PURE__*/React.createElement("span", {
    style: {
      width: p ? 6 : 7,
      height: p ? 6 : 7,
      background: p ? 'var(--cortex)' : 'var(--synapse)'
    }
  }), children);
}
Object.assign(__ds_scope, { Eyebrow });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/core/Eyebrow.jsx", error: String((e && e.message) || e) }); }

// components/core/IconButton.jsx
try { (() => {
function _extends() { return _extends = Object.assign ? Object.assign.bind() : function (n) { for (var e = 1; e < arguments.length; e++) { var t = arguments[e]; for (var r in t) ({}).hasOwnProperty.call(t, r) && (n[r] = t[r]); } return n; }, _extends.apply(null, arguments); }
const IC = {
  copy: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("rect", {
    x: "9",
    y: "9",
    width: "11",
    height: "11",
    rx: "2"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M5 15V6a2 2 0 0 1 2-2h8"
  })),
  paste: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("rect", {
    x: "6",
    y: "4",
    width: "12",
    height: "17",
    rx: "2"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M9 4h6v3H9z"
  })),
  clear: /*#__PURE__*/React.createElement("path", {
    d: "M7 7l10 10M17 7L7 17"
  }),
  reveal: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("path", {
    d: "M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12z"
  }), /*#__PURE__*/React.createElement("circle", {
    cx: "12",
    cy: "12",
    r: "2.8"
  })),
  hide: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("path", {
    d: "M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12z"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M4 20L20 4"
  })),
  link: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("path", {
    d: "M10 14a4 4 0 0 0 5.66 0l3-3a4 4 0 0 0-5.66-5.66l-1 1"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M14 10a4 4 0 0 0-5.66 0l-3 3a4 4 0 0 0 5.66 5.66l1-1"
  })),
  download: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("path", {
    d: "M12 4v11M7 10.5l5 5 5-5"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M5 20h14"
  })),
  ok: /*#__PURE__*/React.createElement("path", {
    d: "M5 12.5l4.5 4.5L19 7.5"
  })
};
const AL = {
  copy: 'Copiar',
  paste: 'Colar',
  clear: 'Limpar',
  reveal: 'Mostrar',
  link: 'Copiar link',
  download: 'Baixar'
};
function IconButton({
  icon = 'copy',
  value,
  label,
  size = 'md',
  onClick,
  style,
  ...rest
}) {
  const [h, setH] = React.useState(false);
  const [fv, setFv] = React.useState(false);
  const [done, setDone] = React.useState(false);
  const t = React.useRef();
  const s = size === 'sm' ? 26 : 32;
  const run = async e => {
    onClick && onClick(e);
    if ((icon === 'copy' || icon === 'link') && value != null) {
      try {
        await navigator.clipboard.writeText(String(value));
        setDone(true);
        clearTimeout(t.current);
        t.current = setTimeout(() => setDone(false), 1600);
      } catch (_) {}
    }
  };
  const lab = done ? 'Copiado' : label || AL[icon] || icon;
  return /*#__PURE__*/React.createElement("button", _extends({
    type: "button",
    "aria-label": lab,
    title: lab,
    onClick: run,
    onMouseEnter: () => setH(true),
    onMouseLeave: () => setH(false),
    onFocus: e => setFv(e.target.matches(':focus-visible')),
    onBlur: () => setFv(false),
    style: {
      flex: 'none',
      display: 'inline-flex',
      alignItems: 'center',
      justifyContent: 'center',
      width: s,
      height: s,
      padding: 0,
      border: 'none',
      borderRadius: size === 'sm' ? 5 : 6,
      background: h ? 'rgba(255,255,255,.11)' : 'rgba(255,255,255,.055)',
      color: done ? 'var(--fn-nominal-primary)' : h ? 'var(--ink)' : 'var(--nevoa)',
      cursor: 'pointer',
      outline: fv ? '2px solid var(--synapse)' : 'none',
      outlineOffset: 1,
      verticalAlign: 'middle',
      transition: 'background var(--t-fast),color var(--t-fast)',
      ...style
    }
  }, rest), /*#__PURE__*/React.createElement("svg", {
    viewBox: "0 0 24 24",
    width: size === 'sm' ? 13 : 15,
    height: size === 'sm' ? 13 : 15,
    fill: "none",
    stroke: "currentColor",
    strokeWidth: "1.7",
    strokeLinecap: "round",
    strokeLinejoin: "round"
  }, IC[done ? 'ok' : icon]));
}
Object.assign(__ds_scope, { IconButton });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/core/IconButton.jsx", error: String((e && e.message) || e) }); }

// components/core/Pill.jsx
try { (() => {
const K = {
  nominal: 'nominal',
  caution: 'caution',
  critical: 'critical',
  signal: 'signal',
  idle: 'idle',
  vital: 'nominal',
  mielina: 'caution',
  pulso: 'critical',
  plasma: 'signal',
  ion: 'signal',
  dendrito: 'idle'
};
function Pill({
  status,
  children
}) {
  const f = K[status],
    c = f ? `var(--fn-${f}-primary)` : null;
  return /*#__PURE__*/React.createElement("span", {
    style: {
      display: 'inline-flex',
      flex: 'none',
      whiteSpace: 'nowrap',
      alignItems: 'center',
      gap: 7,
      fontFamily: 'var(--fm)',
      fontWeight: 500,
      fontSize: 10.5,
      letterSpacing: '.06em',
      textTransform: 'uppercase',
      border: '1px solid ' + (c ? `color-mix(in srgb, ${c} 45%, transparent)` : 'var(--line2)'),
      borderRadius: 5,
      padding: '3px 10px',
      color: c || 'var(--nevoa)'
    }
  }, c && /*#__PURE__*/React.createElement("span", {
    style: {
      width: 6,
      height: 6,
      borderRadius: 1,
      background: c
    }
  }), children);
}
Object.assign(__ds_scope, { Pill });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/core/Pill.jsx", error: String((e && e.message) || e) }); }

// components/core/Switch.jsx
try { (() => {
const FN = {
  nominal: 'var(--fn-nominal-primary)',
  caution: 'var(--fn-caution-primary)',
  critical: 'var(--fn-critical-primary)',
  signal: 'var(--fn-signal-primary)',
  idle: 'var(--fn-idle-primary)'
};
const SI = {
  nominal: /*#__PURE__*/React.createElement("path", {
    d: "M5 12.5l4.5 4.5L19 7.5"
  }),
  caution: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("path", {
    d: "M12 4l9 16H3z"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M12 10v4M12 17v.2"
  })),
  critical: /*#__PURE__*/React.createElement("path", {
    d: "M7 7l10 10M17 7L7 17"
  }),
  signal: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("circle", {
    cx: "12",
    cy: "12",
    r: "2"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M7.8 7.8a6 6 0 0 0 0 8.4M16.2 7.8a6 6 0 0 1 0 8.4"
  })),
  idle: /*#__PURE__*/React.createElement("path", {
    d: "M9 6v12M15 6v12"
  })
};
function Switch({
  items = [],
  active = 0,
  onChange,
  label
}) {
  const [a, setA] = React.useState(active);
  const list = items.slice(0, 3);
  return /*#__PURE__*/React.createElement("div", {
    role: "radiogroup",
    "aria-label": label,
    style: {
      display: 'inline-flex',
      alignItems: 'center',
      gap: 2,
      height: 30,
      padding: 2,
      boxSizing: 'border-box',
      border: '1px solid var(--line)',
      borderRadius: 8,
      background: 'rgba(255,255,255,.03)'
    }
  }, list.map((it, i) => {
    const o = typeof it === 'string' ? {
      label: it
    } : it;
    const on = i === a;
    const c = on && o.status ? FN[o.status] : null;
    return /*#__PURE__*/React.createElement("button", {
      key: i,
      role: "radio",
      "aria-checked": on,
      "aria-label": o.iconOnly ? o.label : undefined,
      title: o.iconOnly ? o.label : undefined,
      onClick: () => {
        setA(i);
        onChange && onChange(i);
      },
      style: {
        display: 'inline-flex',
        alignItems: 'center',
        justifyContent: 'center',
        gap: 6,
        minWidth: 34,
        height: '100%',
        padding: o.iconOnly ? '0 8px' : '0 10px',
        border: 'none',
        borderRadius: 6,
        cursor: 'pointer',
        whiteSpace: 'nowrap',
        fontFamily: 'var(--fd)',
        fontWeight: 600,
        fontSize: 11,
        letterSpacing: '.1em',
        textTransform: 'uppercase',
        background: on ? c ? 'color-mix(in srgb, ' + c + ' 14%, transparent)' : 'rgba(255,255,255,.09)' : 'transparent',
        color: on ? c || 'var(--ink)' : 'var(--nevoa)',
        transition: 'background var(--t-fast),color var(--t-fast)'
      }
    }, o.status && (on || o.iconOnly) && /*#__PURE__*/React.createElement("svg", {
      viewBox: "0 0 24 24",
      width: "13",
      height: "13",
      fill: "none",
      stroke: "currentColor",
      strokeWidth: "2",
      strokeLinecap: "round",
      strokeLinejoin: "round"
    }, SI[o.status]), !o.iconOnly && o.label);
  }));
}
Object.assign(__ds_scope, { Switch });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/core/Switch.jsx", error: String((e && e.message) || e) }); }

// components/core/Tag.jsx
try { (() => {
function Tag({
  children
}) {
  return /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--fd)',
      fontWeight: 600,
      fontSize: 10,
      letterSpacing: '.12em',
      textTransform: 'uppercase',
      color: 'var(--synapse)',
      border: '1px solid rgba(206,220,0,.35)',
      borderRadius: 5,
      padding: '3px 9px'
    }
  }, children);
}
Object.assign(__ds_scope, { Tag });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/core/Tag.jsx", error: String((e && e.message) || e) }); }

// components/formal/DataTable.jsx
try { (() => {
function DataTable({
  columns = [],
  rows = [],
  caption
}) {
  return /*#__PURE__*/React.createElement("figure", {
    style: {
      margin: 0
    }
  }, /*#__PURE__*/React.createElement("table", {
    style: {
      width: '100%',
      borderCollapse: 'collapse',
      fontSize: 12,
      color: 'var(--formal-ink)',
      fontFamily: 'var(--fd)'
    }
  }, /*#__PURE__*/React.createElement("thead", null, /*#__PURE__*/React.createElement("tr", null, columns.map((c, i) => /*#__PURE__*/React.createElement("th", {
    key: i,
    style: {
      fontWeight: 500,
      fontSize: 11,
      color: 'var(--formal-ink-2)',
      textAlign: i ? 'right' : 'left',
      padding: '8px 10px',
      borderTop: '1.5px solid var(--formal-rule-strong)',
      borderBottom: '1px solid var(--formal-rule-strong)'
    }
  }, c)))), /*#__PURE__*/React.createElement("tbody", null, rows.map((r, j) => /*#__PURE__*/React.createElement("tr", {
    key: j
  }, r.map((v, i) => /*#__PURE__*/React.createElement("td", {
    key: i,
    style: {
      padding: '8px 10px',
      textAlign: i ? 'right' : 'left',
      fontWeight: 300,
      fontVariantNumeric: 'tabular-nums',
      borderBottom: j === rows.length - 1 ? '1.5px solid var(--formal-rule-strong)' : '1px solid var(--formal-rule)'
    }
  }, v)))))), caption && /*#__PURE__*/React.createElement("figcaption", {
    style: {
      fontFamily: 'var(--fs-formal)',
      fontStyle: 'italic',
      fontSize: 13,
      color: 'var(--formal-ink-2)',
      marginTop: 8
    }
  }, caption));
}
Object.assign(__ds_scope, { DataTable });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/formal/DataTable.jsx", error: String((e && e.message) || e) }); }

// components/formal/Kicker.jsx
try { (() => {
function Kicker({
  variant = 'rule',
  label,
  index,
  family = 'cortex'
}) {
  const dark = `var(--${family}-dark)`,
    prim = `var(--${family}-primary)`,
    light = `var(--${family}-light)`;
  if (variant === 'folio') return /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      alignItems: 'flex-start',
      gap: 12
    }
  }, /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--fs-formal)',
      fontSize: 56,
      lineHeight: .8,
      color: family === 'cortex' ? 'var(--cortex-primary)' : dark
    }
  }, index), /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--fd)',
      fontWeight: 500,
      fontSize: 14,
      lineHeight: 1.3,
      color: 'var(--formal-ink)',
      paddingTop: 2,
      maxWidth: 160
    }
  }, label));
  if (variant === 'tint') return /*#__PURE__*/React.createElement("div", {
    style: {
      background: light,
      borderRadius: 10,
      padding: '12px 14px',
      display: 'inline-block'
    }
  }, /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--fs-formal)',
      fontStyle: 'italic',
      fontSize: 19,
      color: dark
    }
  }, label));
  return /*#__PURE__*/React.createElement("div", null, /*#__PURE__*/React.createElement("div", {
    style: {
      height: 1,
      background: dark
    }
  }), /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      justifyContent: 'space-between',
      alignItems: 'baseline',
      marginTop: 10
    }
  }, /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--fd)',
      fontWeight: 500,
      fontSize: 14,
      color: dark
    }
  }, label), index && /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--fs-formal)',
      fontStyle: 'italic',
      fontSize: 18,
      color: dark
    }
  }, index)));
}
Object.assign(__ds_scope, { Kicker });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/formal/Kicker.jsx", error: String((e && e.message) || e) }); }

// components/formal/Letterhead.jsx
try { (() => {
function Letterhead({
  reference,
  date,
  classification,
  family = 'cortex'
}) {
  const base = typeof window !== 'undefined' && window.NRO_ASSET_BASE || '';
  const dark = `var(--${family}-dark)`;
  const m = `url(${base}assets/logo-imagotipo-black.png) left/contain no-repeat`;
  return /*#__PURE__*/React.createElement("header", {
    style: {
      display: 'flex',
      flexDirection: 'column',
      gap: 14
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      justifyContent: 'space-between',
      alignItems: 'flex-end'
    }
  }, /*#__PURE__*/React.createElement("div", {
    role: "img",
    "aria-label": "NeuroDynamics",
    style: {
      width: 118,
      height: 20,
      background: dark,
      WebkitMask: m,
      mask: m
    }
  }), /*#__PURE__*/React.createElement("div", {
    style: {
      textAlign: 'right',
      fontFamily: 'var(--fd)',
      fontWeight: 300,
      fontSize: 11,
      color: 'var(--formal-ink-2)',
      lineHeight: 1.5
    }
  }, reference && /*#__PURE__*/React.createElement("div", null, reference), date && /*#__PURE__*/React.createElement("div", null, date))), /*#__PURE__*/React.createElement("div", {
    style: {
      height: 1,
      background: dark
    }
  }), classification && /*#__PURE__*/React.createElement("div", {
    style: {
      fontFamily: 'var(--fs-formal)',
      fontStyle: 'italic',
      fontSize: 14,
      color: dark
    }
  }, classification));
}
Object.assign(__ds_scope, { Letterhead });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/formal/Letterhead.jsx", error: String((e && e.message) || e) }); }

// components/formal/SignatureBlock.jsx
try { (() => {
function SignatureBlock({
  name,
  role,
  org = 'NeuroDynamics',
  align = 'left'
}) {
  return /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      flexDirection: 'column',
      alignItems: align === 'center' ? 'center' : 'flex-start',
      minWidth: 220
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      width: 220,
      height: 1,
      background: 'var(--formal-rule-strong)',
      marginBottom: 10
    }
  }), /*#__PURE__*/React.createElement("div", {
    style: {
      fontFamily: 'var(--fs-formal)',
      fontSize: 20,
      color: 'var(--formal-ink)',
      lineHeight: 1.1
    }
  }, name), /*#__PURE__*/React.createElement("div", {
    style: {
      fontFamily: 'var(--fd)',
      fontWeight: 300,
      fontSize: 12,
      color: 'var(--formal-ink-2)',
      marginTop: 3
    }
  }, role, org ? ', ' + org : ''));
}
Object.assign(__ds_scope, { SignatureBlock });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/formal/SignatureBlock.jsx", error: String((e && e.message) || e) }); }

// components/interface/Band.jsx
try { (() => {
const IC = {
  calendar: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("rect", {
    x: "3.5",
    y: "5",
    width: "17",
    height: "15",
    rx: "2"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M3.5 10h17M8 3v4M16 3v4"
  })),
  mail: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("rect", {
    x: "3",
    y: "5.5",
    width: "18",
    height: "13",
    rx: "2"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M3.5 7l8.5 6 8.5-6"
  })),
  download: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("path", {
    d: "M12 4v11M7 10.5l5 5 5-5"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M5 20h14"
  })),
  chart: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("path", {
    d: "M4 20V4M4 20h16"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M8 16v-4M12 16V8M16 16v-6"
  })),
  users: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("circle", {
    cx: "9",
    cy: "8.5",
    r: "3.5"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M2.5 20c.8-3.6 3.4-5.5 6.5-5.5s5.7 1.9 6.5 5.5"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M15.5 5.2a3.5 3.5 0 0 1 0 6.6M18 14.8c1.8.8 3 2.5 3.5 5.2"
  })),
  doc: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("path", {
    d: "M6 3h8l4 4v14H6z"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M14 3v4h4M9 12h6M9 16h6"
  })),
  spark: /*#__PURE__*/React.createElement("path", {
    d: "M12 3v5M12 16v5M3 12h5M16 12h5M6 6l3 3M15 15l3 3M18 6l-3 3M9 15l-3 3"
  }),
  pulse: /*#__PURE__*/React.createElement("path", {
    d: "M3 12h4l2-6 4 12 2-6h6"
  })
};
const Ico = ({
  k,
  stroke,
  style,
  w = 1.1
}) => IC[k] ? /*#__PURE__*/React.createElement("svg", {
  "aria-hidden": "true",
  viewBox: "0 0 24 24",
  fill: "none",
  stroke: stroke,
  strokeWidth: w,
  strokeLinecap: "round",
  strokeLinejoin: "round",
  style: style
}, IC[k]) : null;
const T = {
  fontFamily: 'var(--fd)',
  fontSize: 'clamp(24px,3.8vw,40px)',
  fontWeight: 600,
  maxWidth: 560,
  margin: '10px 0',
  letterSpacing: '-.015em',
  lineHeight: 1.08,
  textWrap: 'balance'
};
const Lab = ({
  c,
  sq,
  children
}) => /*#__PURE__*/React.createElement("div", {
  style: {
    display: 'inline-flex',
    alignItems: 'center',
    gap: 10,
    fontFamily: 'var(--fd)',
    fontWeight: 600,
    fontSize: 11,
    letterSpacing: '.16em',
    textTransform: 'uppercase',
    color: c
  }
}, /*#__PURE__*/React.createElement("span", {
  style: {
    width: 7,
    height: 7,
    background: sq
  }
}), children);
const PAD = 'clamp(34px,5vw,56px)';
function Band({
  eyebrow,
  title,
  children,
  action,
  family,
  icon
}) {
  if (!family) {
    return /*#__PURE__*/React.createElement("div", {
      style: {
        background: 'linear-gradient(118deg,var(--cortex) 0%,var(--axon) 62%,#0A6F62 100%)',
        borderRadius: 24,
        padding: PAD,
        position: 'relative',
        overflow: 'hidden',
        border: '1px solid rgba(206,220,0,.18)',
        color: 'var(--ink)'
      }
    }, /*#__PURE__*/React.createElement("div", {
      style: {
        position: 'absolute',
        right: -90,
        top: -90,
        width: 330,
        height: 330,
        borderRadius: '50%',
        background: 'radial-gradient(circle,rgba(206,220,0,.22),transparent 70%)',
        filter: 'blur(34px)'
      }
    }), /*#__PURE__*/React.createElement(Ico, {
      k: icon,
      stroke: "rgba(245,245,247,.10)",
      style: {
        position: 'absolute',
        right: -20,
        bottom: -34,
        width: 'clamp(150px,24vw,220px)'
      }
    }), /*#__PURE__*/React.createElement("div", {
      style: {
        position: 'relative'
      }
    }, eyebrow && /*#__PURE__*/React.createElement(Lab, {
      c: "rgba(245,245,247,.72)",
      sq: "var(--synapse)"
    }, eyebrow), /*#__PURE__*/React.createElement("h2", {
      style: T
    }, title), /*#__PURE__*/React.createElement("p", {
      style: {
        color: 'rgba(245,245,247,.78)',
        maxWidth: 520,
        margin: '0 0 24px',
        fontSize: 14.5
      }
    }, children), action));
  }
  const v = n => 'var(--' + family + '-' + n + ')';
  return /*#__PURE__*/React.createElement("div", {
    style: {
      borderRadius: 24,
      padding: PAD,
      position: 'relative',
      overflow: 'hidden',
      background: 'var(--sulco-primary)',
      border: '1px solid color-mix(in srgb, ' + v('primary') + ' 22%, transparent)',
      color: 'var(--ink)'
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      position: 'absolute',
      right: '-12%',
      bottom: '-60%',
      width: '70%',
      aspectRatio: '1',
      borderRadius: '50%',
      background: 'radial-gradient(circle,color-mix(in srgb, ' + v('primary') + ' 38%, transparent),transparent 68%)',
      filter: 'blur(40px)'
    }
  }), /*#__PURE__*/React.createElement("div", {
    style: {
      position: 'absolute',
      inset: 0,
      backgroundImage: 'linear-gradient(rgba(255,255,255,.035) 1px,transparent 1px),linear-gradient(90deg,rgba(255,255,255,.035) 1px,transparent 1px)',
      backgroundSize: '28px 28px',
      WebkitMaskImage: 'linear-gradient(90deg,transparent 35%,#000)',
      maskImage: 'linear-gradient(90deg,transparent 35%,#000)'
    }
  }), /*#__PURE__*/React.createElement(Ico, {
    k: icon,
    stroke: v('medium'),
    w: 0.7,
    style: {
      position: 'absolute',
      right: '-6%',
      top: '50%',
      transform: 'translateY(-50%)',
      width: 'clamp(220px,34vw,320px)',
      opacity: .06
    }
  }), /*#__PURE__*/React.createElement("div", {
    style: {
      position: 'relative',
      maxWidth: '62%'
    }
  }, eyebrow && /*#__PURE__*/React.createElement(Lab, {
    c: v('medium'),
    sq: v('primary')
  }, eyebrow), /*#__PURE__*/React.createElement("h2", {
    style: T
  }, title), /*#__PURE__*/React.createElement("p", {
    style: {
      color: 'var(--nevoa)',
      maxWidth: 480,
      margin: '0 0 24px',
      fontSize: 14.5,
      lineHeight: 1.5
    }
  }, children), action));
}
Object.assign(__ds_scope, { Band });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/Band.jsx", error: String((e && e.message) || e) }); }

// components/interface/BarList.jsx
try { (() => {
const F = {
  cortex: ['#E3EFEC', '#A9CCC4', '#00594F', '#00352F'],
  ion: ['#D9F7F2', '#93E8DB', '#5BBFB0', '#0B4F48'],
  neuron: ['#E4F2E3', '#B3D9B0', '#5AA65E', '#1F4A22'],
  retina: ['#E0E6FC', '#A9B9F6', '#3456E3', '#142A75'],
  nexo: ['#E7E5FA', '#BAB4F0', '#5A4ED4', '#251C66'],
  dendrito: ['#EEE8FE', '#CDBEFC', '#A78BFA', '#3B2378']
};
function BarList({
  items = [],
  family = 'ion',
  tick = 1.5
}) {
  const t = F[family] || F.ion;
  const max = Math.max(...items.map(i => i.value), 1);
  return /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'grid',
      gridTemplateColumns: 'max-content minmax(0,1fr) max-content',
      columnGap: 10,
      rowGap: 11,
      alignItems: 'center'
    }
  }, items.map((it, i) => /*#__PURE__*/React.createElement(React.Fragment, {
    key: i
  }, /*#__PURE__*/React.createElement("span", {
    style: {
      fontSize: 12.5,
      color: 'var(--nevoa)',
      whiteSpace: 'nowrap'
    }
  }, it.label), /*#__PURE__*/React.createElement("div", {
    "aria-hidden": "true",
    style: {
      position: 'relative',
      height: 12,
      minWidth: 0,
      background: 'repeating-linear-gradient(90deg,rgba(255,255,255,.12) 0 ' + tick + 'px,transparent ' + tick + 'px ' + tick * 4 + 'px)'
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      position: 'absolute',
      left: 0,
      top: 0,
      bottom: 0,
      width: it.value / max * 100 + '%',
      background: 'repeating-linear-gradient(90deg,' + t[2] + ' 0 ' + tick + 'px,transparent ' + tick + 'px ' + tick * 4 + 'px)'
    }
  })), /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--fm)',
      fontSize: 11.5,
      color: 'var(--nevoa)',
      textAlign: 'right',
      whiteSpace: 'nowrap'
    }
  }, it.label2 || it.value))));
}
Object.assign(__ds_scope, { BarList });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/BarList.jsx", error: String((e && e.message) || e) }); }

// components/interface/Breadcrumb.jsx
try { (() => {
function Breadcrumb({
  items = []
}) {
  return /*#__PURE__*/React.createElement("nav", {
    "aria-label": "Trilha",
    style: {
      display: 'flex',
      alignItems: 'center',
      gap: 9,
      fontFamily: 'var(--fd)',
      fontWeight: 600,
      fontSize: 10.5,
      letterSpacing: '.12em',
      textTransform: 'uppercase',
      fontSize: 11,
      color: 'var(--grafite)'
    }
  }, items.map((t, i) => /*#__PURE__*/React.createElement(React.Fragment, {
    key: i
  }, i > 0 && /*#__PURE__*/React.createElement("span", {
    style: {
      opacity: .5
    }
  }, "/"), /*#__PURE__*/React.createElement("span", {
    style: {
      color: i === items.length - 1 ? 'var(--nevoa)' : 'var(--grafite)'
    }
  }, t))));
}
Object.assign(__ds_scope, { Breadcrumb });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/Breadcrumb.jsx", error: String((e && e.message) || e) }); }

// components/interface/DataGrid.jsx
try { (() => {
function DataGrid({
  columns = [],
  rows = []
}) {
  const th = {
    fontFamily: 'var(--fd)',
    fontWeight: 600,
    fontSize: 10.5,
    letterSpacing: '.12em',
    textTransform: 'uppercase',
    fontSize: 10,
    color: 'var(--grafite)',
    textAlign: 'left',
    padding: '10px 12px',
    borderBottom: '1px solid var(--line2)'
  };
  return /*#__PURE__*/React.createElement("div", {
    style: {
      overflowX: 'auto'
    }
  }, /*#__PURE__*/React.createElement("table", {
    style: {
      width: '100%',
      borderCollapse: 'collapse',
      fontSize: 13.5,
      fontFamily: 'var(--f)',
      color: 'var(--ink)'
    }
  }, /*#__PURE__*/React.createElement("thead", null, /*#__PURE__*/React.createElement("tr", null, columns.map(c => /*#__PURE__*/React.createElement("th", {
    key: c.key,
    style: {
      ...th,
      textAlign: c.num ? 'right' : 'left'
    }
  }, c.label)))), /*#__PURE__*/React.createElement("tbody", null, rows.map((r, i) => /*#__PURE__*/React.createElement("tr", {
    key: i
  }, columns.map((c, j) => /*#__PURE__*/React.createElement("td", {
    key: c.key,
    style: {
      padding: '13px 12px',
      borderBottom: '1px solid var(--line)',
      textAlign: c.num ? 'right' : 'left',
      fontFamily: c.num ? 'var(--fm)' : 'var(--f)',
      color: c.num ? 'var(--nevoa)' : 'var(--ink)',
      fontWeight: j === 0 ? 600 : 400,
      whiteSpace: c.num ? 'nowrap' : 'normal'
    }
  }, r[c.key])))))));
}
Object.assign(__ds_scope, { DataGrid });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/DataGrid.jsx", error: String((e && e.message) || e) }); }

// components/interface/Dialog.jsx
try { (() => {
function Dialog({
  title,
  children,
  actions
}) {
  return /*#__PURE__*/React.createElement("div", {
    role: "dialog",
    "aria-label": title,
    style: {
      width: 'min(420px,100%)',
      background: 'var(--painel)',
      border: '1px solid var(--line2)',
      borderRadius: 'var(--r-lg)',
      padding: 26,
      boxShadow: '0 30px 80px rgba(0,0,0,.6)',
      boxSizing: 'border-box'
    }
  }, /*#__PURE__*/React.createElement("h3", {
    style: {
      margin: '0 0 7px',
      fontFamily: 'var(--fd)',
      fontSize: 17,
      fontWeight: 600,
      color: 'var(--ink)'
    }
  }, title), /*#__PURE__*/React.createElement("p", {
    style: {
      margin: '0 0 22px',
      fontSize: 13.5,
      lineHeight: 1.6,
      color: 'var(--nevoa)'
    }
  }, children), /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      gap: 10,
      justifyContent: 'flex-end',
      flexWrap: 'wrap'
    }
  }, actions));
}
Object.assign(__ds_scope, { Dialog });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/Dialog.jsx", error: String((e && e.message) || e) }); }

// components/interface/EmptyState.jsx
try { (() => {
function EmptyState({
  title,
  children,
  action
}) {
  return /*#__PURE__*/React.createElement("div", {
    style: {
      border: '1px dashed var(--line2)',
      borderRadius: 'var(--r)',
      padding: '40px 26px',
      background: 'rgba(255,255,255,.015)',
      display: 'flex',
      flexDirection: 'column',
      alignItems: 'flex-start',
      gap: 8
    }
  }, /*#__PURE__*/React.createElement("div", {
    "aria-hidden": "true",
    style: {
      fontFamily: 'var(--fd)',
      fontWeight: 700,
      fontSize: 44,
      lineHeight: 1,
      color: 'rgba(245,245,247,.09)',
      marginBottom: 6
    }
  }, "FIG."), /*#__PURE__*/React.createElement("h3", {
    style: {
      margin: 0,
      fontFamily: 'var(--fd)',
      fontSize: 16,
      fontWeight: 600,
      color: 'var(--ink)'
    }
  }, title), /*#__PURE__*/React.createElement("p", {
    style: {
      margin: '0 0 10px',
      fontSize: 13,
      color: 'var(--nevoa)',
      maxWidth: 420
    }
  }, children), action);
}
Object.assign(__ds_scope, { EmptyState });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/EmptyState.jsx", error: String((e && e.message) || e) }); }

// components/interface/Field.jsx
try { (() => {
function _extends() { return _extends = Object.assign ? Object.assign.bind() : function (n) { for (var e = 1; e < arguments.length; e++) { var t = arguments[e]; for (var r in t) ({}).hasOwnProperty.call(t, r) && (n[r] = t[r]); } return n; }, _extends.apply(null, arguments); }
const ST = {
  ok: 'var(--fn-nominal-primary)',
  error: 'var(--fn-critical-primary)'
};
function Select({
  id,
  options,
  value,
  defaultValue,
  onChange,
  base,
  setF,
  f,
  dis
}) {
  const [open, setOpen] = React.useState(false);
  const [v, setV] = React.useState(value ?? defaultValue ?? options[0]);
  const [hi, setHi] = React.useState(Math.max(0, options.indexOf(value ?? defaultValue ?? options[0])));
  const ref = React.useRef(null);
  React.useEffect(() => {
    if (!open) return;
    const h = e => {
      if (ref.current && !ref.current.contains(e.target)) setOpen(false);
    };
    document.addEventListener('mousedown', h);
    return () => document.removeEventListener('mousedown', h);
  }, [open]);
  const pick = i => {
    setV(options[i]);
    setHi(i);
    setOpen(false);
    onChange && onChange(options[i]);
  };
  const key = e => {
    if (e.key === 'ArrowDown') {
      e.preventDefault();
      if (!open) setOpen(true);else setHi(h => Math.min(options.length - 1, h + 1));
    } else if (e.key === 'ArrowUp') {
      e.preventDefault();
      setHi(h => Math.max(0, h - 1));
    } else if (e.key === 'Enter' || e.key === ' ') {
      e.preventDefault();
      open ? pick(hi) : setOpen(true);
    } else if (e.key === 'Escape') {
      setOpen(false);
    }
  };
  return /*#__PURE__*/React.createElement("div", {
    ref: ref,
    style: {
      position: 'relative'
    }
  }, /*#__PURE__*/React.createElement("button", {
    id: id,
    type: "button",
    disabled: dis,
    "aria-haspopup": "listbox",
    "aria-expanded": open,
    onClick: () => setOpen(o => !o),
    onKeyDown: key,
    onFocus: () => setF(true),
    onBlur: () => setF(false),
    style: {
      ...base,
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'space-between',
      gap: 10,
      textAlign: 'left',
      cursor: 'pointer',
      borderColor: open || f ? 'var(--synapse)' : base.borderColor
    }
  }, /*#__PURE__*/React.createElement("span", {
    style: {
      overflow: 'hidden',
      textOverflow: 'ellipsis',
      whiteSpace: 'nowrap'
    }
  }, v), /*#__PURE__*/React.createElement("svg", {
    viewBox: "0 0 24 24",
    width: "16",
    height: "16",
    fill: "none",
    stroke: "currentColor",
    strokeWidth: "1.7",
    strokeLinecap: "round",
    strokeLinejoin: "round",
    style: {
      flex: 'none',
      color: 'var(--nevoa)',
      transform: open ? 'rotate(180deg)' : 'none',
      transition: 'transform var(--t-fast)'
    }
  }, /*#__PURE__*/React.createElement("path", {
    d: "M6 9l6 6 6-6"
  }))), open && /*#__PURE__*/React.createElement("ul", {
    role: "listbox",
    style: {
      position: 'absolute',
      zIndex: 20,
      left: 0,
      right: 0,
      top: 'calc(100% + 6px)',
      margin: 0,
      padding: 6,
      listStyle: 'none',
      background: 'var(--painel)',
      border: '1px solid var(--line2)',
      borderRadius: 'var(--r-sm)',
      boxShadow: '0 18px 50px rgba(0,0,0,.45)',
      maxHeight: 240,
      overflowY: 'auto'
    }
  }, options.map((o, i) => {
    const s = o === v,
      h = i === hi;
    return /*#__PURE__*/React.createElement("li", {
      key: o,
      role: "option",
      "aria-selected": s,
      onMouseEnter: () => setHi(i),
      onMouseDown: e => {
        e.preventDefault();
        pick(i);
      },
      style: {
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
        gap: 10,
        height: 34,
        padding: '0 10px',
        borderRadius: 7,
        fontSize: 13.5,
        cursor: 'pointer',
        color: s || h ? 'var(--ink)' : 'var(--nevoa)',
        fontWeight: s ? 600 : 400,
        background: h ? 'rgba(255,255,255,.06)' : 'transparent'
      }
    }, /*#__PURE__*/React.createElement("span", {
      style: {
        overflow: 'hidden',
        textOverflow: 'ellipsis',
        whiteSpace: 'nowrap'
      }
    }, o), s && /*#__PURE__*/React.createElement("svg", {
      viewBox: "0 0 24 24",
      width: "14",
      height: "14",
      fill: "none",
      stroke: "currentColor",
      strokeWidth: "2",
      strokeLinecap: "round",
      strokeLinejoin: "round",
      style: {
        flex: 'none',
        color: 'var(--nevoa)'
      }
    }, /*#__PURE__*/React.createElement("path", {
      d: "M5 12.5l4.5 4.5L19 7.5"
    })));
  })));
}
const IC = {
  copy: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("rect", {
    x: "9",
    y: "9",
    width: "11",
    height: "11",
    rx: "2"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M5 15V6a2 2 0 0 1 2-2h8"
  })),
  paste: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("rect", {
    x: "6",
    y: "4",
    width: "12",
    height: "17",
    rx: "2"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M9 4h6v3H9z"
  })),
  clear: /*#__PURE__*/React.createElement("path", {
    d: "M7 7l10 10M17 7L7 17"
  }),
  reveal: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("path", {
    d: "M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12z"
  }), /*#__PURE__*/React.createElement("circle", {
    cx: "12",
    cy: "12",
    r: "2.8"
  })),
  hide: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("path", {
    d: "M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12z"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M4 20L20 4"
  })),
  ok: /*#__PURE__*/React.createElement("path", {
    d: "M5 12.5l4.5 4.5L19 7.5"
  })
};
const AL = {
  copy: 'Copiar',
  paste: 'Colar',
  clear: 'Limpar',
  reveal: 'Mostrar'
};
function setNative(el, v) {
  const s = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set;
  s.call(el, v);
  el.dispatchEvent(new Event('input', {
    bubbles: true
  }));
}
function FieldAction({
  a,
  inp,
  shown,
  setShown,
  iconOnly
}) {
  const o = typeof a === 'string' ? {
    kind: a
  } : a;
  const k = o.kind;
  const [done, setDone] = React.useState(false);
  const [h, setH] = React.useState(false);
  const [fv, setFv] = React.useState(false);
  const run = async () => {
    const el = inp.current;
    if (o.onClick) {
      o.onClick(el && el.value);
    }
    try {
      if (k === 'copy' && el) {
        await navigator.clipboard.writeText(el.value);
        flash();
      } else if (k === 'paste' && el) {
        const t = await navigator.clipboard.readText();
        setNative(el, t);
        el.focus();
        flash();
      } else if (k === 'clear' && el) {
        setNative(el, '');
        el.focus();
      } else if (k === 'reveal') {
        setShown(s => !s);
      }
    } catch (e) {}
  };
  const flash = () => {
    setDone(true);
    clearTimeout(run.t);
    run.t = setTimeout(() => setDone(false), 1600);
  };
  const lab = done ? k === 'copy' ? 'Copiado' : 'Colado' : k === 'reveal' ? shown ? 'Ocultar' : 'Mostrar' : o.label || AL[k];
  const ic = done ? 'ok' : k === 'reveal' && shown ? 'hide' : k;
  return /*#__PURE__*/React.createElement("button", {
    type: "button",
    "aria-label": lab,
    title: iconOnly ? lab : undefined,
    onClick: run,
    onMouseEnter: () => setH(true),
    onMouseLeave: () => setH(false),
    onFocus: e => setFv(e.target.matches(':focus-visible')),
    onBlur: () => setFv(false),
    style: {
      flex: 'none',
      display: 'inline-flex',
      alignItems: 'center',
      gap: 6,
      height: 30,
      padding: iconOnly ? '0' : '0 10px',
      width: iconOnly ? 30 : 'auto',
      justifyContent: 'center',
      border: 'none',
      borderRadius: 6,
      background: h ? 'rgba(255,255,255,.11)' : 'rgba(255,255,255,.055)',
      color: done ? 'var(--fn-nominal-primary)' : h ? 'var(--ink)' : 'var(--nevoa)',
      fontFamily: 'var(--fd)',
      fontWeight: 600,
      fontSize: 10.5,
      letterSpacing: '.1em',
      textTransform: 'uppercase',
      cursor: 'pointer',
      outline: fv ? '2px solid var(--synapse)' : 'none',
      outlineOffset: 1,
      transition: 'background var(--t-fast),color var(--t-fast)'
    }
  }, /*#__PURE__*/React.createElement("svg", {
    viewBox: "0 0 24 24",
    width: "15",
    height: "15",
    fill: "none",
    stroke: "currentColor",
    strokeWidth: "1.7",
    strokeLinecap: "round",
    strokeLinejoin: "round"
  }, IC[ic]), !iconOnly && /*#__PURE__*/React.createElement("span", null, lab));
}
function SubmitBtn({
  label,
  dis
}) {
  const [h, setH] = React.useState(false);
  const [fv, setFv] = React.useState(false);
  return /*#__PURE__*/React.createElement("button", {
    type: "submit",
    "aria-label": label,
    title: label,
    disabled: dis,
    onMouseEnter: () => setH(true),
    onMouseLeave: () => setH(false),
    onFocus: e => setFv(e.target.matches(':focus-visible')),
    onBlur: () => setFv(false),
    style: {
      flex: 'none',
      display: 'inline-flex',
      alignItems: 'center',
      justifyContent: 'center',
      width: 34,
      height: 34,
      padding: 0,
      border: 'none',
      borderRadius: 6,
      background: 'var(--synapse)',
      color: 'var(--cortex)',
      cursor: 'pointer',
      outline: fv ? '2px solid var(--ink)' : 'none',
      outlineOffset: 2,
      boxShadow: h ? '0 6px 20px rgba(206,220,0,.22)' : 'none',
      transition: 'box-shadow var(--t-fast)'
    }
  }, /*#__PURE__*/React.createElement("svg", {
    viewBox: "0 0 24 24",
    width: "16",
    height: "16",
    fill: "none",
    stroke: "currentColor",
    strokeWidth: "2",
    strokeLinecap: "round",
    strokeLinejoin: "round"
  }, /*#__PURE__*/React.createElement("path", {
    d: "M5 12h14M13 6l6 6-6 6"
  })));
}
function Field({
  label,
  type = 'text',
  hint,
  state = 'default',
  options = [],
  rows = 3,
  id,
  style,
  actions,
  iconOnly = true,
  submit,
  ...rest
}) {
  const [f, setF] = React.useState(false);
  const dis = state === 'disabled';
  const border = f ? 'var(--synapse)' : ST[state] ? ST[state] : 'var(--line2)';
  const base = {
    width: '100%',
    boxSizing: 'border-box',
    background: f ? 'rgba(206,220,0,.04)' : 'rgba(255,255,255,.05)',
    border: '1px solid ' + border,
    borderRadius: 'var(--r-sm)',
    padding: '10px 12px',
    color: 'var(--ink)',
    fontFamily: 'var(--f)',
    fontSize: 15,
    lineHeight: 1.5,
    outline: 'none',
    transition: 'border-color var(--t-fast),background var(--t-fast)',
    opacity: dis ? .4 : 1,
    pointerEvents: dis ? 'none' : 'auto'
  };
  const inp = React.useRef(null);
  const [shown, setShown] = React.useState(false);
  const ev = {
    id,
    disabled: dis,
    onFocus: () => setF(true),
    onBlur: () => setF(false),
    ...rest
  };
  const ctl = type === 'select' ? /*#__PURE__*/React.createElement(Select, {
    id: id,
    options: options,
    value: rest.value,
    defaultValue: rest.defaultValue,
    onChange: rest.onChange,
    base: base,
    setF: setF,
    f: f,
    dis: dis
  }) : type === 'textarea' ? /*#__PURE__*/React.createElement("textarea", _extends({
    rows: rows
  }, ev, {
    style: {
      ...base,
      resize: 'vertical'
    }
  })) : submit ? /*#__PURE__*/React.createElement("form", {
    onSubmit: e => {
      e.preventDefault();
      const o = typeof submit === 'object' ? submit : {};
      o.onSubmit && o.onSubmit(inp.current && inp.current.value);
    },
    style: {
      ...base,
      display: 'flex',
      alignItems: 'center',
      gap: 6,
      padding: '4px 4px 4px 12px',
      margin: 0
    }
  }, /*#__PURE__*/React.createElement("input", _extends({
    ref: inp,
    type: type
  }, ev, {
    style: {
      flex: 1,
      minWidth: 0,
      background: 'transparent',
      border: 'none',
      outline: 'none',
      padding: '6px 0',
      color: 'inherit',
      font: 'inherit',
      lineHeight: 1.5
    }
  })), /*#__PURE__*/React.createElement(SubmitBtn, {
    label: typeof submit === 'object' && submit.label || 'Enviar',
    dis: dis
  })) : actions && actions.length ? /*#__PURE__*/React.createElement("div", {
    style: {
      ...base,
      display: 'flex',
      alignItems: 'center',
      gap: 4,
      padding: '4px 4px 4px 12px'
    }
  }, /*#__PURE__*/React.createElement("input", _extends({
    ref: inp,
    type: type === 'password' && shown ? 'text' : type
  }, ev, {
    style: {
      flex: 1,
      minWidth: 0,
      background: 'transparent',
      border: 'none',
      outline: 'none',
      padding: '6px 0',
      color: 'inherit',
      font: 'inherit',
      lineHeight: 1.5
    }
  })), actions.map((a, i) => /*#__PURE__*/React.createElement(React.Fragment, {
    key: i
  }, /*#__PURE__*/React.createElement(FieldAction, {
    a: a,
    inp: inp,
    shown: shown,
    setShown: setShown,
    iconOnly: iconOnly
  })))) : /*#__PURE__*/React.createElement("input", _extends({
    type: type
  }, ev, {
    style: base
  }));
  return /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      flexDirection: 'column',
      gap: 7,
      ...style
    }
  }, /*#__PURE__*/React.createElement("label", {
    htmlFor: id,
    style: {
      fontFamily: 'var(--fd)',
      fontWeight: 600,
      fontSize: 10.5,
      letterSpacing: '.12em',
      textTransform: 'uppercase',
      color: 'var(--nevoa)'
    }
  }, label), ctl, hint && /*#__PURE__*/React.createElement("p", {
    style: {
      margin: 0,
      fontSize: 11.5,
      lineHeight: 1.45,
      color: ST[state] || 'var(--grafite)'
    }
  }, hint));
}
Object.assign(__ds_scope, { Field });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/Field.jsx", error: String((e && e.message) || e) }); }

// components/interface/FilterBar.jsx
try { (() => {
const Box = ({
  on
}) => /*#__PURE__*/React.createElement("span", {
  style: {
    width: 14,
    height: 14,
    flex: 'none',
    borderRadius: 3,
    border: '1px solid ' + (on ? 'var(--ink)' : 'var(--line2)'),
    background: on ? 'var(--ink)' : 'transparent',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center'
  }
}, on && /*#__PURE__*/React.createElement("svg", {
  viewBox: "0 0 24 24",
  width: "11",
  height: "11",
  fill: "none",
  stroke: "#050807",
  strokeWidth: "3",
  strokeLinecap: "round",
  strokeLinejoin: "round"
}, /*#__PURE__*/React.createElement("path", {
  d: "M5 12.5l4.5 4.5L19 7.5"
})));
function Group({
  g,
  sel,
  toggle,
  clear
}) {
  const [open, setOpen] = React.useState(false);
  const ref = React.useRef(null);
  const n = sel.length;
  React.useEffect(() => {
    if (!open) return;
    const h = e => {
      if (ref.current && !ref.current.contains(e.target)) setOpen(false);
    };
    document.addEventListener('mousedown', h);
    return () => document.removeEventListener('mousedown', h);
  }, [open]);
  return /*#__PURE__*/React.createElement("div", {
    ref: ref,
    style: {
      position: 'relative'
    }
  }, /*#__PURE__*/React.createElement("button", {
    type: "button",
    "aria-haspopup": "listbox",
    "aria-expanded": open,
    onClick: () => setOpen(o => !o),
    style: {
      display: 'inline-flex',
      alignItems: 'center',
      gap: 8,
      height: 32,
      padding: '0 10px 0 12px',
      borderRadius: 8,
      border: '1px solid ' + (open || n ? 'var(--line2)' : 'var(--line)'),
      background: n ? 'rgba(255,255,255,.07)' : 'rgba(255,255,255,.02)',
      color: n ? 'var(--ink)' : 'var(--nevoa)',
      fontFamily: 'var(--f)',
      fontSize: 12.5,
      fontWeight: n ? 600 : 500,
      cursor: 'pointer'
    }
  }, g.label, n > 0 && /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--fm)',
      fontSize: 10,
      lineHeight: '16px',
      padding: '0 5px',
      borderRadius: 4,
      background: 'var(--ink)',
      color: '#050807'
    }
  }, n), /*#__PURE__*/React.createElement("svg", {
    viewBox: "0 0 24 24",
    width: "14",
    height: "14",
    fill: "none",
    stroke: "currentColor",
    strokeWidth: "1.7",
    strokeLinecap: "round",
    strokeLinejoin: "round",
    style: {
      color: 'var(--grafite)',
      transform: open ? 'rotate(180deg)' : 'none',
      transition: 'transform var(--t-fast)'
    }
  }, /*#__PURE__*/React.createElement("path", {
    d: "M6 9l6 6 6-6"
  }))), open && /*#__PURE__*/React.createElement("div", {
    role: "listbox",
    "aria-multiselectable": "true",
    style: {
      position: 'absolute',
      zIndex: 20,
      left: 0,
      top: 'calc(100% + 6px)',
      minWidth: 220,
      padding: 6,
      background: 'var(--painel)',
      border: '1px solid var(--line2)',
      borderRadius: 'var(--r-sm)',
      boxShadow: '0 18px 50px rgba(0,0,0,.45)'
    }
  }, g.options.map(o => {
    const on = sel.includes(o);
    return /*#__PURE__*/React.createElement("div", {
      key: o,
      role: "option",
      "aria-selected": on,
      onClick: () => toggle(o),
      style: {
        display: 'flex',
        alignItems: 'center',
        gap: 10,
        height: 34,
        padding: '0 10px',
        borderRadius: 7,
        fontSize: 13.5,
        cursor: 'pointer',
        color: on ? 'var(--ink)' : 'var(--nevoa)'
      },
      onMouseEnter: e => e.currentTarget.style.background = 'rgba(255,255,255,.06)',
      onMouseLeave: e => e.currentTarget.style.background = 'transparent'
    }, /*#__PURE__*/React.createElement(Box, {
      on: on
    }), o);
  }), /*#__PURE__*/React.createElement("div", {
    style: {
      height: 1,
      background: 'var(--line)',
      margin: '6px 4px'
    }
  }), /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      justifyContent: 'space-between',
      padding: '2px 4px'
    }
  }, /*#__PURE__*/React.createElement("button", {
    type: "button",
    onClick: clear,
    style: {
      border: 'none',
      background: 'none',
      cursor: 'pointer',
      fontFamily: 'var(--f)',
      fontSize: 12.5,
      color: 'var(--nevoa)',
      padding: '6px'
    }
  }, "Limpar"), /*#__PURE__*/React.createElement("button", {
    type: "button",
    onClick: () => setOpen(false),
    style: {
      border: 'none',
      borderRadius: 7,
      cursor: 'pointer',
      fontFamily: 'var(--fd)',
      fontWeight: 600,
      fontSize: 12,
      background: 'var(--synapse)',
      color: 'var(--cortex)',
      padding: '6px 12px'
    }
  }, "Aplicar"))));
}
function FilterBar({
  filters = [],
  count,
  onChange
}) {
  const [s, setS] = React.useState(() => Object.fromEntries(filters.map(f => [f.label, f.selected || []])));
  const up = n => {
    setS(n);
    onChange && onChange(n);
  };
  const toggle = (l, o) => up({
    ...s,
    [l]: s[l].includes(o) ? s[l].filter(x => x !== o) : [...s[l], o]
  });
  const active = filters.flatMap(f => s[f.label].map(o => [f.label, o]));
  return /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      flexDirection: 'column',
      gap: 10
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      alignItems: 'center',
      gap: 8,
      flexWrap: 'wrap'
    }
  }, filters.map(f => /*#__PURE__*/React.createElement(Group, {
    key: f.label,
    g: f,
    sel: s[f.label],
    toggle: o => toggle(f.label, o),
    clear: () => up({
      ...s,
      [f.label]: []
    })
  })), count != null && /*#__PURE__*/React.createElement("span", {
    style: {
      marginLeft: 'auto',
      fontSize: 12.5,
      color: 'var(--grafite)'
    }
  }, /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--fm)',
      color: 'var(--nevoa)'
    }
  }, count), " resultados")), active.length > 0 && /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      alignItems: 'center',
      gap: 6,
      flexWrap: 'wrap'
    }
  }, active.map(([l, o]) => /*#__PURE__*/React.createElement("span", {
    key: l + o,
    style: {
      display: 'inline-flex',
      alignItems: 'center',
      gap: 6,
      height: 24,
      padding: '0 4px 0 9px',
      borderRadius: 6,
      border: '1px solid var(--line2)',
      background: 'rgba(255,255,255,.04)',
      fontSize: 12,
      color: 'var(--ink)'
    }
  }, /*#__PURE__*/React.createElement("span", {
    style: {
      color: 'var(--grafite)'
    }
  }, l, ":"), o, /*#__PURE__*/React.createElement("button", {
    type: "button",
    "aria-label": 'Remover ' + o,
    onClick: () => toggle(l, o),
    style: {
      width: 18,
      height: 18,
      border: 'none',
      borderRadius: 4,
      background: 'transparent',
      color: 'var(--nevoa)',
      cursor: 'pointer',
      fontSize: 13,
      lineHeight: 1
    }
  }, "\xD7"))), /*#__PURE__*/React.createElement("button", {
    type: "button",
    onClick: () => up(Object.fromEntries(filters.map(f => [f.label, []]))),
    style: {
      border: 'none',
      background: 'none',
      cursor: 'pointer',
      fontFamily: 'var(--f)',
      fontSize: 12,
      color: 'var(--nevoa)',
      textDecoration: 'underline',
      textUnderlineOffset: 3
    }
  }, "Limpar filtros")));
}
Object.assign(__ds_scope, { FilterBar });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/FilterBar.jsx", error: String((e && e.message) || e) }); }

// components/interface/Metric.jsx
try { (() => {
const TR = {
  up: ['↑', 'var(--fn-nominal-primary)'],
  down: ['↓', 'var(--fn-critical-primary)'],
  flat: ['', 'var(--grafite)']
};
function Metric({
  label,
  value,
  unit,
  delta,
  trend = 'flat'
}) {
  const [ar, c] = TR[trend] || TR.flat;
  return /*#__PURE__*/React.createElement("div", {
    style: {
      border: '1px solid var(--line)',
      borderRadius: 'var(--r-md)',
      background: 'var(--card)',
      padding: '18px 20px',
      display: 'flex',
      flexDirection: 'column',
      justifyContent: 'space-between',
      gap: 16,
      height: '100%',
      boxSizing: 'border-box'
    }
  }, /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--fd)',
      fontWeight: 600,
      fontSize: 10.5,
      letterSpacing: '.12em',
      textTransform: 'uppercase',
      fontSize: 10,
      color: 'var(--grafite)'
    }
  }, label), /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      flexDirection: 'column',
      gap: 9
    }
  }, /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--fd)',
      fontWeight: 600,
      fontSize: 30,
      letterSpacing: '-.02em',
      lineHeight: 1,
      color: 'var(--ink)'
    }
  }, value, unit && /*#__PURE__*/React.createElement("span", {
    style: {
      fontSize: 16,
      color: 'var(--nevoa)',
      marginLeft: 2
    }
  }, unit)), delta && /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--fm)',
      fontSize: 11,
      color: c
    }
  }, ar && ar + ' ', delta)));
}
Object.assign(__ds_scope, { Metric });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/Metric.jsx", error: String((e && e.message) || e) }); }

// components/interface/Progress.jsx
try { (() => {
function useKF() {
  React.useEffect(() => {
    if (document.getElementById('nro-kf')) return;
    const s = document.createElement('style');
    s.id = 'nro-kf';
    s.textContent = '@keyframes nroShine{0%{background-position:100% 50%}100%{background-position:0 50%}}@keyframes nroSpin{to{transform:rotate(360deg)}}@media (prefers-reduced-motion:reduce){.nro-anim{animation:none!important}}';
    document.head.appendChild(s);
  }, []);
}
function Progress({
  value,
  label
}) {
  useKF();
  const ind = value == null;
  return /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      flexDirection: 'column',
      gap: 12
    }
  }, label && /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      alignItems: 'center',
      gap: 12,
      fontSize: 13.5,
      color: 'var(--nevoa)'
    }
  }, ind && /*#__PURE__*/React.createElement("span", {
    className: "nro-anim",
    style: {
      width: 22,
      height: 22,
      borderRadius: '50%',
      border: '2px solid var(--line2)',
      borderTopColor: 'var(--synapse)',
      animation: 'nroSpin .8s linear infinite',
      flex: 'none'
    }
  }), label), !ind && /*#__PURE__*/React.createElement("div", {
    style: {
      height: 4,
      borderRadius: 3,
      background: 'rgba(255,255,255,.06)',
      overflow: 'hidden'
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      height: '100%',
      width: value + '%',
      borderRadius: 3,
      background: 'linear-gradient(90deg,var(--axon),var(--synapse))'
    }
  })));
}
Object.assign(__ds_scope, { Progress });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/Progress.jsx", error: String((e && e.message) || e) }); }

// components/interface/ProportionBar.jsx
try { (() => {
const F = {
  cortex: ['#E3EFEC', '#A9CCC4', '#00594F', '#00352F'],
  ion: ['#D9F7F2', '#93E8DB', '#5BBFB0', '#0B4F48'],
  neuron: ['#E4F2E3', '#B3D9B0', '#5AA65E', '#1F4A22'],
  retina: ['#E0E6FC', '#A9B9F6', '#3456E3', '#142A75'],
  nexo: ['#E7E5FA', '#BAB4F0', '#5A4ED4', '#251C66'],
  dendrito: ['#EEE8FE', '#CDBEFC', '#A78BFA', '#3B2378']
};
function ProportionBar({
  items = [],
  family = 'cortex'
}) {
  const t = F[family] || F.cortex;
  const tones = [t[3], t[2], t[1], t[0]];
  const tot = items.reduce((a, b) => a + b.value, 0) || 1;
  return /*#__PURE__*/React.createElement("div", null, /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      height: 34,
      borderRadius: 10,
      overflow: 'hidden',
      border: '1px solid var(--line2)',
      marginBottom: 10
    }
  }, items.map((it, i) => /*#__PURE__*/React.createElement("div", {
    key: i,
    style: {
      width: it.value / tot * 100 + '%',
      background: tones[i % 4]
    }
  }))), /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      gap: 16,
      flexWrap: 'wrap',
      fontSize: 12,
      color: 'var(--nevoa)'
    }
  }, items.map((it, i) => /*#__PURE__*/React.createElement("span", {
    key: i,
    style: {
      display: 'inline-flex',
      alignItems: 'center',
      gap: 7
    }
  }, /*#__PURE__*/React.createElement("i", {
    style: {
      width: 9,
      height: 9,
      borderRadius: 2,
      background: tones[i % 4],
      display: 'block'
    }
  }), it.label, /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--fm)'
    }
  }, Math.round(it.value / tot * 100), "%")))));
}
Object.assign(__ds_scope, { ProportionBar });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/ProportionBar.jsx", error: String((e && e.message) || e) }); }

// components/interface/SectionNav.jsx
try { (() => {
function SectionNav({
  items = [],
  active = 0,
  onChange
}) {
  const [a, setA] = React.useState(active);
  return /*#__PURE__*/React.createElement("nav", {
    style: {
      display: 'flex',
      flexWrap: 'wrap',
      gap: 2,
      padding: 4,
      border: '1px solid var(--line)',
      borderRadius: 13,
      width: 'fit-content',
      maxWidth: '100%',
      background: 'rgba(255,255,255,.03)'
    }
  }, items.map((it, i) => {
    const on = i === a;
    const o = typeof it === 'string' ? {
      label: it
    } : it;
    return /*#__PURE__*/React.createElement("button", {
      key: i,
      onClick: () => {
        setA(i);
        onChange && onChange(i);
      },
      style: {
        display: 'inline-flex',
        alignItems: 'center',
        gap: 6,
        fontFamily: 'var(--f)',
        fontSize: 13,
        border: 'none',
        cursor: 'pointer',
        whiteSpace: 'nowrap',
        padding: '6px 13px',
        borderRadius: 9,
        color: on ? 'var(--ink)' : 'var(--nevoa)',
        background: on ? 'rgba(255,255,255,.09)' : 'transparent',
        fontWeight: on ? 600 : 400
      }
    }, o.label, o.count != null && /*#__PURE__*/React.createElement("span", {
      style: {
        fontFamily: 'var(--fm)',
        fontSize: 10,
        lineHeight: '16px',
        padding: '0 6px',
        borderRadius: 4,
        border: '1px solid ' + (o.highlight ? 'var(--synapse)' : 'var(--line2)'),
        background: o.highlight ? 'var(--synapse)' : 'transparent',
        color: o.highlight ? 'var(--cortex)' : 'var(--grafite)'
      }
    }, o.count));
  }));
}
Object.assign(__ds_scope, { SectionNav });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/SectionNav.jsx", error: String((e && e.message) || e) }); }

// components/interface/Segmented.jsx
try { (() => {
function Segmented({
  items = [],
  active = 0,
  onChange
}) {
  const [a, setA] = React.useState(active);
  return /*#__PURE__*/React.createElement("div", {
    role: "radiogroup",
    style: {
      display: 'inline-flex',
      alignItems: 'center',
      gap: 2,
      height: 32,
      padding: 2,
      boxSizing: 'border-box',
      border: '1px solid var(--line)',
      borderRadius: 8,
      background: 'rgba(255,255,255,.02)'
    }
  }, items.map((t, i) => {
    const on = i === a;
    return /*#__PURE__*/React.createElement("button", {
      key: i,
      onClick: () => {
        setA(i);
        onChange && onChange(i);
      },
      style: {
        display: 'inline-flex',
        alignItems: 'center',
        gap: 6,
        fontFamily: 'var(--f)',
        border: 'none',
        cursor: 'pointer',
        whiteSpace: 'nowrap',
        height: '100%',
        padding: '0 11px',
        borderRadius: 6,
        fontSize: 12.5,
        fontWeight: on ? 600 : 500,
        background: on ? 'rgba(255,255,255,.09)' : 'transparent',
        color: on ? 'var(--ink)' : 'var(--nevoa)'
      }
    }, t);
  }));
}
Object.assign(__ds_scope, { Segmented });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/Segmented.jsx", error: String((e && e.message) || e) }); }

// components/interface/SideMenu.jsx
try { (() => {
const P = {
  home: 'M3 10.5 12 3l9 7.5V20a1 1 0 0 1-1 1h-5v-6H9v6H4a1 1 0 0 1-1-1z',
  grid: 'M4 4h7v7H4zM13 4h7v7h-7zM4 13h7v7H4zM13 13h7v7h-7z',
  users: 'M16 20v-1.5a3.5 3.5 0 0 0-3.5-3.5h-5A3.5 3.5 0 0 0 4 18.5V20M10 11a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7M20 20v-1.5a3.5 3.5 0 0 0-2.5-3.35M15.5 4.15a3.5 3.5 0 0 1 0 6.7',
  file: 'M14 3H7a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V8zM14 3v5h5M9 13h6M9 17h6',
  calendar: 'M5 5h14a1 1 0 0 1 1 1v13a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V6a1 1 0 0 1 1-1M16 3v4M8 3v4M4 10h16',
  chart: 'M4 20h16M7 16v-5M12 16V7M17 16v-8',
  settings: 'M12 15a3 3 0 1 0 0-6 3 3 0 0 0 0 6M19.4 15a1.7 1.7 0 0 0 .3 1.8l.1.1a2 2 0 1 1-2.8 2.8l-.1-.1a1.7 1.7 0 0 0-1.8-.3 1.7 1.7 0 0 0-1 1.5V21a2 2 0 1 1-4 0v-.1a1.7 1.7 0 0 0-1.1-1.5 1.7 1.7 0 0 0-1.8.3l-.1.1a2 2 0 1 1-2.8-2.8l.1-.1a1.7 1.7 0 0 0 .3-1.8 1.7 1.7 0 0 0-1.5-1H3a2 2 0 1 1 0-4h.1a1.7 1.7 0 0 0 1.5-1.1 1.7 1.7 0 0 0-.3-1.8l-.1-.1a2 2 0 1 1 2.8-2.8l.1.1a1.7 1.7 0 0 0 1.8.3H9a1.7 1.7 0 0 0 1-1.5V3a2 2 0 1 1 4 0v.1a1.7 1.7 0 0 0 1 1.5 1.7 1.7 0 0 0 1.8-.3l.1-.1a2 2 0 1 1 2.8 2.8l-.1.1a1.7 1.7 0 0 0-.3 1.8V9a1.7 1.7 0 0 0 1.5 1H21a2 2 0 1 1 0 4h-.1a1.7 1.7 0 0 0-1.5 1',
  search: 'M11 18a7 7 0 1 0 0-14 7 7 0 0 0 0 14M20 20l-3.5-3.5',
  bell: 'M6 8a6 6 0 1 1 12 0c0 7 3 9 3 9H3s3-2 3-9M10.3 21a1.9 1.9 0 0 0 3.4 0',
  chev: 'M9 6l6 6-6 6',
  panel: 'M5 4h14a1.5 1.5 0 0 1 1.5 1.5v13A1.5 1.5 0 0 1 19 20H5a1.5 1.5 0 0 1-1.5-1.5v-13A1.5 1.5 0 0 1 5 4M9.5 4v16M16 9.5 13.5 12l2.5 2.5',
  box: 'M21 8 12 3 3 8v8l9 5 9-5zM3 8l9 5 9-5M12 13v8'
};
const Ic = ({
  n,
  s = 18,
  c,
  style
}) => /*#__PURE__*/React.createElement("svg", {
  viewBox: "0 0 24 24",
  width: s,
  height: s,
  fill: "none",
  stroke: "currentColor",
  strokeWidth: "1.7",
  strokeLinecap: "round",
  strokeLinejoin: "round",
  style: {
    flex: 'none',
    color: c,
    ...style
  }
}, /*#__PURE__*/React.createElement("path", {
  d: P[n] || P.grid
}));
function SideMenu({
  app = 'Portal do Membro',
  sections = [],
  active = '',
  activeChild = '',
  collapsed: c0 = false,
  user,
  notifications = 0,
  height = '100%'
}) {
  const base = typeof window !== 'undefined' && window.NRO_ASSET_BASE || '';
  const [col, setCol] = React.useState(c0);
  const [open, setOpen] = React.useState(() => sections.filter(s => s.label === active && s.children).map(s => s.label));
  const [hov, setHov] = React.useState(null);
  const [fly, setFly] = React.useState(null);
  const W = col ? 68 : 252;
  const item = (on, cur, k) => ({
    position: 'relative',
    flex: 1,
    minWidth: 0,
    display: 'flex',
    alignItems: 'center',
    gap: col ? 0 : 12,
    height: 38,
    padding: col ? '0 0 0 25px' : '0 12px 0 15px',
    margin: '0 10px',
    borderRadius: 10,
    border: 'none',
    background: cur || col && on ? 'rgba(255,255,255,.07)' : hov === k ? 'rgba(255,255,255,.05)' : 'transparent',
    color: on || hov === k ? 'var(--ink)' : 'var(--nevoa)',
    fontFamily: 'var(--f)',
    fontSize: 13.5,
    cursor: 'pointer',
    textAlign: 'left'
  });
  const rot = {
    flex: 1,
    minWidth: 0,
    overflow: 'hidden',
    textOverflow: 'ellipsis',
    whiteSpace: 'nowrap',
    opacity: col ? 0 : 1,
    transition: 'opacity var(--t-fast)'
  };
  const child = (ch, i, inFly) => {
    const cur = ch.label === activeChild;
    return /*#__PURE__*/React.createElement("a", {
      key: i,
      href: "#",
      style: {
        position: 'relative',
        display: 'flex',
        alignItems: 'center',
        gap: 8,
        height: 32,
        padding: '0 10px',
        borderRadius: 8,
        fontSize: 13,
        textDecoration: 'none',
        color: cur ? 'var(--ink)' : 'var(--nevoa)',
        background: cur ? 'rgba(255,255,255,.065)' : 'transparent'
      }
    }, cur && !inFly && /*#__PURE__*/React.createElement("span", {
      style: {
        position: 'absolute',
        left: -11,
        top: 8,
        bottom: 8,
        width: 2,
        borderRadius: 2,
        background: 'var(--synapse)'
      }
    }), /*#__PURE__*/React.createElement("span", {
      style: {
        flex: 1,
        minWidth: 0,
        overflow: 'hidden',
        textOverflow: 'ellipsis',
        whiteSpace: 'nowrap'
      }
    }, ch.label), ch.code && /*#__PURE__*/React.createElement("span", {
      style: {
        fontFamily: 'var(--fm)',
        fontSize: 9.5,
        letterSpacing: '.06em',
        color: 'var(--grafite)'
      }
    }, ch.code));
  };
  return /*#__PURE__*/React.createElement("aside", {
    style: {
      position: 'relative',
      width: W,
      height,
      flex: 'none',
      display: 'flex',
      flexDirection: 'column',
      background: 'var(--painel)',
      borderRight: '1px solid var(--line)',
      transition: 'width var(--t) var(--ease)',
      zIndex: 3
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      flex: 'none',
      display: 'flex',
      alignItems: 'center',
      height: 66,
      padding: col ? '0 0 0 20px' : '0 14px 0 20px',
      borderBottom: '1px solid var(--line)',
      overflow: 'hidden'
    }
  }, col ? /*#__PURE__*/React.createElement("div", {
    role: "img",
    "aria-label": "NeuroDynamics",
    style: {
      width: 28,
      height: 28,
      flex: 'none',
      background: 'var(--ink)',
      mask: 'url(' + base + 'assets/icon-square-solid-black.png) center/contain no-repeat',
      WebkitMask: 'url(' + base + 'assets/icon-square-solid-black.png) center/contain no-repeat'
    }
  }) : /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      flexDirection: 'column',
      gap: 7,
      minWidth: 0
    }
  }, /*#__PURE__*/React.createElement("img", {
    src: base + 'assets/logo-imagotipo-white.png',
    alt: "NeuroDynamics",
    style: {
      height: 15,
      width: 'auto',
      display: 'block',
      alignSelf: 'flex-start'
    }
  }), /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--fd)',
      fontWeight: 600,
      letterSpacing: '.14em',
      textTransform: 'uppercase',
      fontSize: 9.5,
      color: 'var(--grafite)',
      whiteSpace: 'nowrap'
    }
  }, app))), /*#__PURE__*/React.createElement("button", {
    style: {
      flex: 'none',
      display: 'flex',
      alignItems: 'center',
      gap: 11,
      height: 36,
      margin: '12px 10px 8px',
      padding: col ? '0 0 0 15px' : '0 10px 0 13px',
      borderRadius: 10,
      border: '1px solid var(--line2)',
      background: 'rgba(255,255,255,.03)',
      color: 'var(--grafite)',
      fontFamily: 'var(--f)',
      fontSize: 13,
      cursor: 'pointer'
    }
  }, /*#__PURE__*/React.createElement(Ic, {
    n: "search",
    s: 16
  }), /*#__PURE__*/React.createElement("span", {
    style: {
      ...rot,
      textAlign: 'left'
    }
  }, "Buscar"), !col && /*#__PURE__*/React.createElement("kbd", {
    style: {
      fontFamily: 'var(--fm)',
      fontSize: 10,
      border: '1px solid var(--line2)',
      borderRadius: 5,
      padding: '1px 6px',
      color: 'var(--grafite)'
    }
  }, "\u2318K")), /*#__PURE__*/React.createElement("nav", {
    style: {
      flex: 1,
      minHeight: 0,
      padding: '2px 0 14px',
      overflow: col ? 'visible' : 'hidden'
    }
  }, sections.map((s, i) => {
    if (s.divider) return col ? /*#__PURE__*/React.createElement("div", {
      key: i,
      style: {
        height: 1,
        background: 'var(--line)',
        margin: '12px 22px 6px'
      }
    }) : /*#__PURE__*/React.createElement("div", {
      key: i,
      style: {
        display: 'flex',
        alignItems: 'center',
        gap: 9,
        margin: '14px 20px 6px 25px',
        fontFamily: 'var(--fd)',
        fontWeight: 600,
        letterSpacing: '.14em',
        textTransform: 'uppercase',
        fontSize: 9.5,
        color: 'var(--grafite)'
      }
    }, s.divider, /*#__PURE__*/React.createElement("span", {
      style: {
        flex: 1,
        height: 1,
        background: 'var(--line)'
      }
    }));
    const on = s.label === active,
      isOpen = open.includes(s.label),
      k = 's' + i;
    return /*#__PURE__*/React.createElement("div", {
      key: i,
      style: {
        position: 'relative'
      },
      onMouseEnter: () => {
        setHov(k);
        if (col && s.children) setFly(k);
      },
      onMouseLeave: () => {
        setHov(null);
        setFly(null);
      }
    }, /*#__PURE__*/React.createElement("div", {
      style: {
        position: 'relative',
        display: 'flex',
        alignItems: 'center'
      }
    }, /*#__PURE__*/React.createElement("button", {
      "aria-current": on && !s.children ? 'page' : undefined,
      onClick: () => s.children && !col && setOpen(o => o.includes(s.label) ? o.filter(x => x !== s.label) : [...o, s.label]),
      style: {
        ...item(on, on && !s.children && !col, k),
        paddingRight: s.children && !col ? 40 : item().padding
      }
    }, /*#__PURE__*/React.createElement(Ic, {
      n: s.icon,
      c: on ? 'var(--synapse)' : hov === k ? 'var(--ink)' : 'var(--grafite)'
    }), /*#__PURE__*/React.createElement("span", {
      style: rot
    }, s.label)), s.children && !col && /*#__PURE__*/React.createElement("span", {
      style: {
        position: 'absolute',
        right: 15,
        top: '50%',
        marginTop: -13,
        width: 26,
        height: 26,
        borderRadius: 7,
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        color: 'var(--grafite)',
        pointerEvents: 'none'
      }
    }, /*#__PURE__*/React.createElement(Ic, {
      n: "chev",
      s: 14,
      style: {
        transform: isOpen ? 'rotate(90deg)' : 'none',
        transition: 'transform var(--t-fast)'
      }
    }))), s.children && !col && isOpen && /*#__PURE__*/React.createElement("div", {
      style: {
        margin: '1px 10px 8px 33px',
        paddingLeft: 10,
        borderLeft: '1px solid var(--line2)',
        display: 'flex',
        flexDirection: 'column'
      }
    }, s.children.map((ch, j) => child(ch, j))), s.children && col && fly === k && /*#__PURE__*/React.createElement("div", {
      style: {
        position: 'absolute',
        zIndex: 5,
        left: 68,
        top: -4,
        paddingLeft: 8
      }
    }, /*#__PURE__*/React.createElement("div", {
      style: {
        minWidth: 220,
        padding: 6,
        border: '1px solid var(--line2)',
        borderRadius: 12,
        background: 'var(--painel)',
        boxShadow: '0 18px 50px rgba(0,0,0,.45)'
      }
    }, /*#__PURE__*/React.createElement("span", {
      style: {
        display: 'block',
        padding: '7px 10px 6px',
        fontFamily: 'var(--fd)',
        fontSize: 13,
        fontWeight: 600,
        color: 'var(--ink)'
      }
    }, s.label), s.children.map((ch, j) => child(ch, j, true)))));
  })), /*#__PURE__*/React.createElement("div", {
    style: {
      flex: 'none',
      borderTop: '1px solid var(--line)',
      padding: '8px 0 10px',
      display: 'flex',
      flexDirection: 'column',
      gap: 2
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      position: 'relative'
    },
    onMouseEnter: () => setHov('n'),
    onMouseLeave: () => setHov(null)
  }, /*#__PURE__*/React.createElement("button", {
    style: item(false, false, 'n')
  }, /*#__PURE__*/React.createElement(Ic, {
    n: "bell",
    c: "var(--grafite)"
  }), /*#__PURE__*/React.createElement("span", {
    style: rot
  }, "Avisos"), notifications > 0 && /*#__PURE__*/React.createElement("span", {
    style: col ? {
      position: 'absolute',
      left: 36,
      top: 4,
      minWidth: 15,
      height: 15,
      fontSize: 8.5,
      padding: '0 4px',
      borderRadius: 4,
      background: 'var(--synapse)',
      color: 'var(--cortex)',
      fontFamily: 'var(--fm)',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center'
    } : {
      minWidth: 17,
      height: 17,
      padding: '0 5px',
      borderRadius: 4,
      background: 'var(--synapse)',
      color: 'var(--cortex)',
      fontFamily: 'var(--fm)',
      fontSize: 10,
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center'
    }
  }, notifications))), user && /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex'
    }
  }, /*#__PURE__*/React.createElement("button", {
    style: {
      ...item(false, false, 'u'),
      height: 46,
      padding: col ? '0 0 0 19px' : '0 12px 0 10px'
    }
  }, /*#__PURE__*/React.createElement("span", {
    style: {
      width: 30,
      height: 30,
      borderRadius: '50%',
      flex: 'none',
      background: 'var(--cortex)',
      color: 'var(--ink)',
      fontFamily: 'var(--fd)',
      fontWeight: 600,
      fontSize: 11.5,
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center'
    }
  }, user.name.split(' ').map(w => w[0]).slice(0, 2).join('')), /*#__PURE__*/React.createElement("span", {
    style: {
      ...rot,
      display: 'flex',
      flexDirection: 'column',
      lineHeight: 1.25
    }
  }, /*#__PURE__*/React.createElement("b", {
    style: {
      fontFamily: 'var(--fd)',
      fontSize: 12.5,
      fontWeight: 600,
      color: 'var(--ink)'
    }
  }, user.name), /*#__PURE__*/React.createElement("small", {
    style: {
      fontSize: 11,
      color: 'var(--grafite)'
    }
  }, user.role)))), /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex'
    },
    onMouseEnter: () => setHov('c'),
    onMouseLeave: () => setHov(null)
  }, /*#__PURE__*/React.createElement("button", {
    onClick: () => setCol(v => !v),
    style: item(false, false, 'c')
  }, /*#__PURE__*/React.createElement(Ic, {
    n: "panel",
    c: "var(--grafite)",
    style: {
      transform: col ? 'scaleX(-1)' : 'none'
    }
  }), /*#__PURE__*/React.createElement("span", {
    style: rot
  }, "Recolher o menu")))));
}
Object.assign(__ds_scope, { SideMenu });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/SideMenu.jsx", error: String((e && e.message) || e) }); }

// components/interface/SiteHeader.jsx
try { (() => {
function SiteHeader({
  links = [],
  active = 0,
  tag,
  cta = 'Entrar',
  scrolled = false
}) {
  const base = typeof window !== 'undefined' && window.NRO_ASSET_BASE || '';
  return /*#__PURE__*/React.createElement("header", {
    style: {
      border: '1px solid ' + (scrolled ? 'var(--line2)' : 'var(--line)'),
      borderRadius: 16,
      background: scrolled ? 'rgba(7,12,10,.8)' : 'var(--glass)',
      backdropFilter: 'var(--blur-glass)',
      WebkitBackdropFilter: 'var(--blur-glass)',
      boxShadow: scrolled ? '0 18px 50px rgba(0,0,0,.45)' : 'none'
    }
  }, /*#__PURE__*/React.createElement("div", {
    style: {
      display: 'flex',
      alignItems: 'center',
      gap: 16,
      height: 58,
      padding: '0 10px 0 20px'
    }
  }, /*#__PURE__*/React.createElement("span", {
    style: {
      display: 'flex',
      alignItems: 'center',
      gap: 10,
      marginRight: 'auto'
    }
  }, /*#__PURE__*/React.createElement("img", {
    src: base + 'assets/logo-imagotipo-white.png',
    alt: "NeuroDynamics",
    style: {
      height: 18,
      width: 'auto',
      display: 'block'
    }
  }), tag && /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--fd)',
      fontWeight: 600,
      fontSize: 10.5,
      letterSpacing: '.12em',
      textTransform: 'uppercase',
      fontSize: 9.5,
      color: 'var(--synapse)',
      border: '1px solid rgba(206,220,0,.35)',
      borderRadius: 5,
      padding: '3px 9px'
    }
  }, tag)), /*#__PURE__*/React.createElement("nav", {
    style: {
      display: 'flex',
      gap: 22,
      fontSize: 13.5
    }
  }, links.map((l, i) => /*#__PURE__*/React.createElement("a", {
    key: i,
    href: "#",
    style: {
      position: 'relative',
      padding: '2px 0',
      color: i === active ? 'var(--ink)' : 'var(--nevoa)',
      textDecoration: 'none'
    }
  }, l, i === active && /*#__PURE__*/React.createElement("span", {
    style: {
      position: 'absolute',
      left: 0,
      right: 0,
      bottom: -3,
      height: 1.5,
      borderRadius: 2,
      background: 'var(--synapse)'
    }
  })))), cta && /*#__PURE__*/React.createElement("button", {
    style: {
      height: 34,
      padding: '0 13px',
      borderRadius: 9,
      border: 'none',
      background: 'var(--synapse)',
      color: 'var(--cortex)',
      fontFamily: 'var(--fd)',
      fontWeight: 600,
      fontSize: 12,
      cursor: 'pointer',
      marginLeft: 6
    }
  }, cta)));
}
Object.assign(__ds_scope, { SiteHeader });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/SiteHeader.jsx", error: String((e && e.message) || e) }); }

// components/interface/Skeleton.jsx
try { (() => {
function useKF() {
  React.useEffect(() => {
    if (document.getElementById('nro-kf')) return;
    const s = document.createElement('style');
    s.id = 'nro-kf';
    s.textContent = '@keyframes nroShine{0%{background-position:100% 50%}100%{background-position:0 50%}}@keyframes nroSpin{to{transform:rotate(360deg)}}@media (prefers-reduced-motion:reduce){.nro-anim{animation:none!important}}';
    document.head.appendChild(s);
  }, []);
}
function Skeleton({
  width = '100%',
  height = 11,
  radius = 7
}) {
  useKF();
  return /*#__PURE__*/React.createElement("div", {
    className: "nro-anim",
    style: {
      width,
      height,
      borderRadius: radius,
      background: 'linear-gradient(90deg,rgba(255,255,255,.04) 25%,rgba(255,255,255,.08) 37%,rgba(255,255,255,.04) 63%)',
      backgroundSize: '400% 100%',
      animation: 'nroShine 1.4s ease infinite'
    }
  });
}
Object.assign(__ds_scope, { Skeleton });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/Skeleton.jsx", error: String((e && e.message) || e) }); }

// components/interface/SpecList.jsx
try { (() => {
function SpecList({
  rows = []
}) {
  return /*#__PURE__*/React.createElement("div", null, rows.map((r, i) => /*#__PURE__*/React.createElement("div", {
    key: i,
    style: {
      display: 'grid',
      gridTemplateColumns: '190px 1fr',
      gap: 18,
      alignItems: 'baseline',
      padding: '13px 4px',
      borderTop: '1px solid var(--line)',
      borderBottom: i === rows.length - 1 ? '1px solid var(--line)' : 'none'
    }
  }, /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--fd)',
      fontWeight: 600,
      fontSize: 10.5,
      letterSpacing: '.12em',
      textTransform: 'uppercase',
      fontSize: 10.5,
      color: 'var(--grafite)'
    }
  }, r.k), /*#__PURE__*/React.createElement("span", {
    style: {
      fontSize: 13.5,
      color: 'var(--ink)'
    }
  }, r.v))));
}
Object.assign(__ds_scope, { SpecList });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/SpecList.jsx", error: String((e && e.message) || e) }); }

// components/interface/Tabs.jsx
try { (() => {
function Tabs({
  items = [],
  active = 0,
  onChange
}) {
  const [a, setA] = React.useState(active);
  return /*#__PURE__*/React.createElement("div", {
    role: "tablist",
    style: {
      display: 'flex',
      gap: 4,
      borderBottom: '1px solid var(--line)'
    }
  }, items.map((t, i) => {
    const on = i === a;
    return /*#__PURE__*/React.createElement("button", {
      role: "tab",
      "aria-selected": on,
      key: i,
      onClick: () => {
        setA(i);
        onChange && onChange(i);
      },
      style: {
        display: 'inline-flex',
        alignItems: 'center',
        gap: 6,
        fontFamily: 'var(--f)',
        fontSize: 13,
        border: 'none',
        cursor: 'pointer',
        whiteSpace: 'nowrap',
        position: 'relative',
        padding: '10px 16px',
        fontSize: 13.5,
        background: 'transparent',
        borderRadius: '9px 9px 0 0',
        color: on ? 'var(--ink)' : 'var(--nevoa)',
        fontWeight: on ? 600 : 400
      }
    }, t, on && /*#__PURE__*/React.createElement("span", {
      style: {
        position: 'absolute',
        left: 12,
        right: 12,
        bottom: -1,
        height: 2,
        borderRadius: 2,
        background: 'var(--synapse)'
      }
    }));
  }));
}
Object.assign(__ds_scope, { Tabs });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/Tabs.jsx", error: String((e && e.message) || e) }); }

// components/interface/Toast.jsx
try { (() => {
function Toast({
  status = 'nominal',
  children,
  action,
  onAction
}) {
  return /*#__PURE__*/React.createElement("div", {
    role: "status",
    style: {
      display: 'inline-flex',
      alignItems: 'center',
      gap: 11,
      background: '#151B19',
      border: '1px solid var(--line2)',
      borderRadius: 12,
      padding: '12px 20px',
      fontSize: 13.5,
      color: 'var(--ink)',
      boxShadow: '0 12px 40px rgba(0,0,0,.5)'
    }
  }, /*#__PURE__*/React.createElement("span", {
    style: {
      width: 7,
      height: 7,
      borderRadius: 1,
      flex: 'none',
      background: 'var(--fn-' + status + '-primary)'
    }
  }), children, action && /*#__PURE__*/React.createElement("button", {
    onClick: onAction,
    style: {
      border: 'none',
      background: 'none',
      cursor: 'pointer',
      fontFamily: 'var(--fd)',
      fontWeight: 600,
      fontSize: 12.5,
      color: 'var(--synapse)',
      marginLeft: 6
    }
  }, action));
}
Object.assign(__ds_scope, { Toast });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/Toast.jsx", error: String((e && e.message) || e) }); }

// components/interface/Widget.jsx
try { (() => {
const IC = {
  calendar: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("rect", {
    x: "3.5",
    y: "5",
    width: "17",
    height: "15",
    rx: "2"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M3.5 10h17M8 3v4M16 3v4"
  })),
  mail: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("rect", {
    x: "3",
    y: "5.5",
    width: "18",
    height: "13",
    rx: "2"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M3.5 7l8.5 6 8.5-6"
  })),
  chart: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("path", {
    d: "M4 20V4M4 20h16"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M8 16v-4M12 16V8M16 16v-6"
  })),
  users: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("circle", {
    cx: "9",
    cy: "8.5",
    r: "3.5"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M2.5 20c.8-3.6 3.4-5.5 6.5-5.5s5.7 1.9 6.5 5.5"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M15.5 5.2a3.5 3.5 0 0 1 0 6.6M18 14.8c1.8.8 3 2.5 3.5 5.2"
  })),
  doc: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("path", {
    d: "M6 3h8l4 4v14H6z"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M14 3v4h4M9 12h6M9 16h6"
  })),
  pulse: /*#__PURE__*/React.createElement("path", {
    d: "M3 12h4l2-6 4 12 2-6h6"
  }),
  trophy: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("path", {
    d: "M8 4h8v5a4 4 0 0 1-8 0z"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M8 6H5v1a3 3 0 0 0 3 3M16 6h3v1a3 3 0 0 1-3 3M12 13v4M8.5 20h7M10 17h4"
  })),
  flame: /*#__PURE__*/React.createElement("path", {
    d: "M12 3c1 3 5 5 5 10a5 5 0 0 1-10 0c0-2.5 1.5-4 2.5-5 .3 1.6 1 2.6 2 3 0-3-.5-5.5.5-8z"
  }),
  alert: /*#__PURE__*/React.createElement(React.Fragment, null, /*#__PURE__*/React.createElement("path", {
    d: "M12 3.5l9.5 16.5h-19z"
  }), /*#__PURE__*/React.createElement("path", {
    d: "M12 10v4.5M12 17.2v.3"
  }))
};
const LAB = {
  fontFamily: 'var(--fd)',
  fontWeight: 600,
  fontSize: 11,
  letterSpacing: '.16em',
  textTransform: 'uppercase',
  lineHeight: 1,
  display: 'inline-flex',
  alignItems: 'center',
  gap: 10
};
function Widget({
  label,
  meta,
  family,
  icon,
  slides,
  interval = 12,
  children,
  pad = 24,
  style
}) {
  const n = slides ? slides.length : 0;
  const [i, setI] = React.useState(0);
  const [p, setP] = React.useState(0);
  const [vis, setVis] = React.useState(true);
  React.useEffect(() => {
    if (n < 2) return;
    let t0 = Date.now();
    const id = setInterval(() => {
      const e = (Date.now() - t0) / 1000;
      if (e >= interval) {
        t0 = Date.now();
        setP(0);
        setVis(false);
        setTimeout(() => {
          setI(x => (x + 1) % n);
          setVis(true);
        }, 280);
      } else setP(e / interval);
    }, 100);
    return () => clearInterval(id);
  }, [n, interval]);
  const cur = n ? slides[i % n] : null;
  const fam = cur && cur.family || !cur && family || null;
  const ic = cur && cur.icon || !cur && icon || null;
  const v = k => 'var(--' + fam + '-' + k + ')';
  const lab = cur && cur.label || label;
  const mt = cur && cur.meta || meta;
  return /*#__PURE__*/React.createElement("section", {
    style: {
      position: 'relative',
      overflow: 'hidden',
      borderRadius: 18,
      background: 'rgba(11,18,16,.78)',
      backdropFilter: 'blur(18px)',
      WebkitBackdropFilter: 'blur(18px)',
      border: '1px solid ' + (fam ? 'color-mix(in srgb, ' + v('primary') + ' 24%, transparent)' : 'var(--line)'),
      padding: pad,
      display: 'flex',
      flexDirection: 'column',
      gap: 18,
      minHeight: 0,
      minWidth: 0,
      boxSizing: 'border-box',
      color: 'var(--ink)',
      transition: 'border-color .6s',
      ...style
    }
  }, fam && /*#__PURE__*/React.createElement("div", {
    "aria-hidden": "true",
    style: {
      position: 'absolute',
      right: '-15%',
      bottom: '-55%',
      width: '75%',
      aspectRatio: '1',
      borderRadius: '50%',
      background: 'radial-gradient(circle,color-mix(in srgb, ' + v('primary') + ' 40%, transparent),transparent 68%)',
      filter: 'blur(40px)',
      pointerEvents: 'none'
    }
  }), fam && /*#__PURE__*/React.createElement("div", {
    "aria-hidden": "true",
    style: {
      position: 'absolute',
      inset: 0,
      backgroundImage: 'linear-gradient(rgba(255,255,255,.035) 1px,transparent 1px),linear-gradient(90deg,rgba(255,255,255,.035) 1px,transparent 1px)',
      backgroundSize: '28px 28px',
      WebkitMaskImage: 'linear-gradient(90deg,transparent 35%,#000)',
      maskImage: 'linear-gradient(90deg,transparent 35%,#000)',
      pointerEvents: 'none'
    }
  }), ic && IC[ic] && /*#__PURE__*/React.createElement("svg", {
    "aria-hidden": "true",
    viewBox: "0 0 24 24",
    fill: "none",
    stroke: fam ? v('medium') : 'var(--ink)',
    strokeWidth: "0.7",
    strokeLinecap: "round",
    strokeLinejoin: "round",
    style: {
      position: 'absolute',
      right: '-6%',
      top: '50%',
      transform: 'translateY(-50%)',
      width: 'min(60%,340px)',
      opacity: .06,
      pointerEvents: 'none'
    }
  }, IC[ic]), (lab || mt || n > 1) && /*#__PURE__*/React.createElement("header", {
    style: {
      position: 'relative',
      display: 'flex',
      alignItems: 'center',
      gap: 14,
      minHeight: 14
    }
  }, lab && /*#__PURE__*/React.createElement("span", {
    style: {
      ...LAB,
      color: fam ? v('medium') : 'var(--nevoa)'
    }
  }, /*#__PURE__*/React.createElement("span", {
    style: {
      width: 7,
      height: 7,
      background: fam ? v('primary') : 'var(--cortex-medium)'
    }
  }), lab), /*#__PURE__*/React.createElement("span", {
    style: {
      flex: 1
    }
  }), mt && /*#__PURE__*/React.createElement("span", {
    style: {
      fontFamily: 'var(--fm)',
      fontSize: 12,
      color: 'var(--nevoa)'
    }
  }, mt), n > 1 && /*#__PURE__*/React.createElement("span", {
    "aria-hidden": "true",
    style: {
      display: 'flex',
      gap: 4
    }
  }, slides.map((_, k) => /*#__PURE__*/React.createElement("span", {
    key: k,
    style: {
      width: 18,
      height: 3,
      background: 'rgba(255,255,255,.12)',
      borderRadius: 2,
      overflow: 'hidden'
    }
  }, /*#__PURE__*/React.createElement("span", {
    style: {
      display: 'block',
      height: '100%',
      width: (k < i ? 100 : k === i ? p * 100 : 0) + '%',
      background: 'var(--synapse)'
    }
  }))))), /*#__PURE__*/React.createElement("div", {
    style: {
      position: 'relative',
      flex: 1,
      minHeight: 0,
      display: 'flex',
      flexDirection: 'column',
      opacity: vis ? 1 : 0,
      transform: vis ? 'none' : 'translateY(6px)',
      transition: 'opacity .28s,transform .28s'
    }
  }, cur ? cur.content : children));
}
Object.assign(__ds_scope, { Widget });
})(); } catch (e) { __ds_ns.__errors.push({ path: "components/interface/Widget.jsx", error: String((e && e.message) || e) }); }

__ds_ns.Alert = __ds_scope.Alert;

__ds_ns.Button = __ds_scope.Button;

__ds_ns.Card = __ds_scope.Card;

__ds_ns.Chip = __ds_scope.Chip;

__ds_ns.Eyebrow = __ds_scope.Eyebrow;

__ds_ns.IconButton = __ds_scope.IconButton;

__ds_ns.Pill = __ds_scope.Pill;

__ds_ns.Switch = __ds_scope.Switch;

__ds_ns.Tag = __ds_scope.Tag;

__ds_ns.DataTable = __ds_scope.DataTable;

__ds_ns.Kicker = __ds_scope.Kicker;

__ds_ns.Letterhead = __ds_scope.Letterhead;

__ds_ns.SignatureBlock = __ds_scope.SignatureBlock;

__ds_ns.Band = __ds_scope.Band;

__ds_ns.BarList = __ds_scope.BarList;

__ds_ns.Breadcrumb = __ds_scope.Breadcrumb;

__ds_ns.DataGrid = __ds_scope.DataGrid;

__ds_ns.Dialog = __ds_scope.Dialog;

__ds_ns.EmptyState = __ds_scope.EmptyState;

__ds_ns.Field = __ds_scope.Field;

__ds_ns.FilterBar = __ds_scope.FilterBar;

__ds_ns.Metric = __ds_scope.Metric;

__ds_ns.Progress = __ds_scope.Progress;

__ds_ns.ProportionBar = __ds_scope.ProportionBar;

__ds_ns.SectionNav = __ds_scope.SectionNav;

__ds_ns.Segmented = __ds_scope.Segmented;

__ds_ns.SideMenu = __ds_scope.SideMenu;

__ds_ns.SiteHeader = __ds_scope.SiteHeader;

__ds_ns.Skeleton = __ds_scope.Skeleton;

__ds_ns.SpecList = __ds_scope.SpecList;

__ds_ns.Tabs = __ds_scope.Tabs;

__ds_ns.Toast = __ds_scope.Toast;

__ds_ns.Widget = __ds_scope.Widget;

})();
