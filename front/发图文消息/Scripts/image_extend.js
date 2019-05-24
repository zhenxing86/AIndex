!function () { function j(a) { return !!a.exifdata } function k(a, b) { var c, d, e, f, g; for (b = b || a.match(/^data\:([^\;]+)\;base64,/im)[1] || "", a = a.replace(/^data\:([^\;]+)\;base64,/gim, ""), c = atob(a), d = c.length, e = new ArrayBuffer(d), f = new Uint8Array(e), g = 0; d > g; g++) f[g] = c.charCodeAt(g); return e } function l(a, b) { var c = new XMLHttpRequest; c.open("GET", a, !0), c.responseType = "blob", c.onload = function () { (200 == this.status || 0 === this.status) && b(this.response) }, c.send() } function m(b, d) { function e(a) { var f, g, e = o(a); b.exifdata = e || {}, f = p(a), b.iptcdata = f || {}, c.isXmpEnabled && (g = y(a), b.xmpdata = g || {}), d && d.call(b) } var f, g, h; b.src ? /^data\:/i.test(b.src) ? (f = k(b.src), e(f)) : /^blob\:/i.test(b.src) ? (g = new FileReader, g.onload = function (a) { e(a.target.result) }, l(b.src, function (a) { g.readAsArrayBuffer(a) })) : (h = new XMLHttpRequest, h.onload = function () { if (200 != this.status && 0 !== this.status) throw "Could not load image"; e(h.response), h = null }, h.open("GET", b.src, !0), h.responseType = "arraybuffer", h.send(null)) : self.FileReader && (b instanceof self.Blob || b instanceof self.File) && (g = new FileReader, g.onload = function (b) { a && console.log("Got file of length " + b.target.result.byteLength), e(b.target.result) }, g.readAsArrayBuffer(b)) } function o(b) { var f, d, e, c = new DataView(b); if (a && console.log("Got file of length " + b.byteLength), 255 != c.getUint8(0) || 216 != c.getUint8(1)) return a && console.log("Not a valid JPEG"), !1; for (d = 2, e = b.byteLength; e > d;) { if (255 != c.getUint8(d)) return a && console.log("Not a valid marker at offset " + d + ", found: " + c.getUint8(d)), !1; if (f = c.getUint8(d + 1), a && console.log(f), 225 == f) return a && console.log("Found 0xFFE1 marker"), x(c, d + 4, c.getUint16(d + 2) - 2); d += 2 + c.getUint16(d + 2) } } function p(b) { var d, e, f, g, h, i, c = new DataView(b); if (a && console.log("Got file of length " + b.byteLength), 255 != c.getUint8(0) || 216 != c.getUint8(1)) return a && console.log("Not a valid JPEG"), !1; for (d = 2, e = b.byteLength, f = function (a, b) { return 56 === a.getUint8(b) && 66 === a.getUint8(b + 1) && 73 === a.getUint8(b + 2) && 77 === a.getUint8(b + 3) && 4 === a.getUint8(b + 4) && 4 === a.getUint8(b + 5) }; e > d;) { if (f(c, d)) return g = c.getUint8(d + 7), 0 !== g % 2 && (g += 1), 0 === g && (g = 4), h = d + 8 + g, i = c.getUint16(d + 6 + g), r(b, h, i); d++ } } function r(a, b, c) { for (var f, g, h, i, j, d = new DataView(a), e = {}, k = b; b + c > k;) 28 === d.getUint8(k) && 2 === d.getUint8(k + 1) && (i = d.getUint8(k + 2), i in q && (h = d.getInt16(k + 3), j = h + 5, g = q[i], f = w(d, k + 5, h), e.hasOwnProperty(g) ? e[g] instanceof Array ? e[g].push(f) : e[g] = [e[g], f] : e[g] = f)), k++; return e } function s(b, c, d, e, f) { var i, j, k, g = b.getUint16(d, !f), h = {}; for (k = 0; g > k; k++) i = d + 12 * k + 2, j = e[b.getUint16(i, !f)], !j && a && console.log("Unknown tag: " + b.getUint16(i, !f)), h[j] = t(b, i, c, d, f); return h } function t(a, b, c, d, e) { var i, j, k, l, m, n, f = a.getUint16(b + 2, !e), g = a.getUint32(b + 4, !e), h = a.getUint32(b + 8, !e) + c; switch (f) { case 1: case 7: if (1 == g) return a.getUint8(b + 8, !e); for (i = g > 4 ? h : b + 8, j = [], l = 0; g > l; l++) j[l] = a.getUint8(i + l); return j; case 2: return i = g > 4 ? h : b + 8, w(a, i, g - 1); case 3: if (1 == g) return a.getUint16(b + 8, !e); for (i = g > 2 ? h : b + 8, j = [], l = 0; g > l; l++) j[l] = a.getUint16(i + 2 * l, !e); return j; case 4: if (1 == g) return a.getUint32(b + 8, !e); for (j = [], l = 0; g > l; l++) j[l] = a.getUint32(h + 4 * l, !e); return j; case 5: if (1 == g) return m = a.getUint32(h, !e), n = a.getUint32(h + 4, !e), k = new Number(m / n), k.numerator = m, k.denominator = n, k; for (j = [], l = 0; g > l; l++) m = a.getUint32(h + 8 * l, !e), n = a.getUint32(h + 4 + 8 * l, !e), j[l] = new Number(m / n), j[l].numerator = m, j[l].denominator = n; return j; case 9: if (1 == g) return a.getInt32(b + 8, !e); for (j = [], l = 0; g > l; l++) j[l] = a.getInt32(h + 4 * l, !e); return j; case 10: if (1 == g) return a.getInt32(h, !e) / a.getInt32(h + 4, !e); for (j = [], l = 0; g > l; l++) j[l] = a.getInt32(h + 8 * l, !e) / a.getInt32(h + 4 + 8 * l, !e); return j } } function u(a, b, c) { var d = a.getUint16(b, !c); return a.getUint32(b + 2 + 12 * d, !c) } function v(a, b, c, d) { var f, h, i, e = u(a, b + c, d); if (!e) return {}; if (e > a.byteLength) return {}; if (f = s(a, b, b + e, g, d), f["Compression"]) switch (f["Compression"]) { case 6: f.JpegIFOffset && f.JpegIFByteCount && (h = b + f.JpegIFOffset, i = f.JpegIFByteCount, f["blob"] = new Blob([new Uint8Array(a.buffer, h, i)], { type: "image/jpeg" })); break; case 1: console.log("Thumbnail image format is TIFF, which is not implemented."); break; default: console.log("Unknown thumbnail image format '%s'", f["Compression"]) } else 2 == f["PhotometricInterpretation"] && console.log("Thumbnail image format is RGB, which is not implemented."); return f } function w(a, b, c) { var d = ""; for (n = b; b + c > n; n++) d += String.fromCharCode(a.getUint8(n)); return d } function x(b, c) { var g, i, j, k, l, m, n; if ("Exif" != w(b, c, 4)) return a && console.log("Not valid EXIF data! " + w(b, c, 4)), !1; if (m = c + 6, 18761 == b.getUint16(m)) g = !1; else { if (19789 != b.getUint16(m)) return a && console.log("Not valid TIFF data! (no 0x4949 or 0x4D4D)"), !1; g = !0 } if (42 != b.getUint16(m + 2, !g)) return a && console.log("Not valid TIFF data! (no 0x002A)"), !1; if (n = b.getUint32(m + 4, !g), 8 > n) return a && console.log("Not valid TIFF data! (First offset less than 8)", b.getUint32(m + 4, !g)), !1; if (i = s(b, m, m + n, e, g), i.ExifIFDPointer) { k = s(b, m, m + i.ExifIFDPointer, d, g); for (j in k) { switch (j) { case "LightSource": case "Flash": case "MeteringMode": case "ExposureProgram": case "SensingMethod": case "SceneCaptureType": case "SceneType": case "CustomRendered": case "WhiteBalance": case "GainControl": case "Contrast": case "Saturation": case "Sharpness": case "SubjectDistanceRange": case "FileSource": k[j] = h[j][k[j]]; break; case "ExifVersion": case "FlashpixVersion": k[j] = String.fromCharCode(k[j][0], k[j][1], k[j][2], k[j][3]); break; case "ComponentsConfiguration": k[j] = h.Components[k[j][0]] + h.Components[k[j][1]] + h.Components[k[j][2]] + h.Components[k[j][3]] } i[j] = k[j] } } if (i.GPSInfoIFDPointer) { l = s(b, m, m + i.GPSInfoIFDPointer, f, g); for (j in l) { switch (j) { case "GPSVersionID": l[j] = l[j][0] + "." + l[j][1] + "." + l[j][2] + "." + l[j][3] } i[j] = l[j] } } return i["thumbnail"] = v(b, m, n, g), i } function y(b) { var c, d, e, f, g, h, i, j, k, l; if ("DOMParser" in self) { if (c = new DataView(b), a && console.log("Got file of length " + b.byteLength), 255 != c.getUint8(0) || 216 != c.getUint8(1)) return a && console.log("Not a valid JPEG"), !1; for (d = 2, e = b.byteLength, f = new DOMParser; e - 4 > d;) { if ("http" == w(c, d, 4)) return g = d - 1, h = c.getUint16(d - 2) - 1, i = w(c, g, h), j = i.indexOf("xmpmeta>") + 8, i = i.substring(i.indexOf("<x:xmpmeta"), j), k = i.indexOf("x:xmpmeta") + 10, i = i.slice(0, k) + 'xmlns:Iptc4xmpCore="http://iptc.org/std/Iptc4xmpCore/1.0/xmlns/" ' + 'xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' + 'xmlns:tiff="http://ns.adobe.com/tiff/1.0/" ' + 'xmlns:plus="http://schemas.android.com/apk/lib/com.google.android.gms.plus" ' + 'xmlns:ext="http://www.gettyimages.com/xsltExtension/1.0" ' + 'xmlns:exif="http://ns.adobe.com/exif/1.0/" ' + 'xmlns:stEvt="http://ns.adobe.com/xap/1.0/sType/ResourceEvent#" ' + 'xmlns:stRef="http://ns.adobe.com/xap/1.0/sType/ResourceRef#" ' + 'xmlns:crs="http://ns.adobe.com/camera-raw-settings/1.0/" ' + 'xmlns:xapGImg="http://ns.adobe.com/xap/1.0/g/img/" ' + 'xmlns:Iptc4xmpExt="http://iptc.org/std/Iptc4xmpExt/2008-02-29/" ' + i.slice(k), l = f.parseFromString(i, "text/xml"), A(l); d++ } } } function z(a) { var c, d, e, f, g, h, b = {}; if (1 == a.nodeType) { if (a.attributes.length > 0) for (b["@attributes"] = {}, c = 0; c < a.attributes.length; c++) d = a.attributes.item(c), b["@attributes"][d.nodeName] = d.nodeValue } else if (3 == a.nodeType) return a.nodeValue; if (a.hasChildNodes()) for (e = 0; e < a.childNodes.length; e++) f = a.childNodes.item(e), g = f.nodeName, null == b[g] ? b[g] = z(f) : (null == b[g].push && (h = b[g], b[g] = [], b[g].push(h)), b[g].push(z(f))); return b } function A(a) { var b, c, d, e, f, g, h, i, j, k; try { if (b = {}, a.children.length > 0) for (c = 0; c < a.children.length; c++) { d = a.children.item(c), e = d.attributes; for (f in e) g = e[f], h = g.nodeName, i = g.nodeValue, void 0 !== h && (b[h] = i); j = d.nodeName, "undefined" == typeof b[j] ? b[j] = z(d) : ("undefined" == typeof b[j].push && (k = b[j], b[j] = [], b[j].push(k)), b[j].push(z(d))) } else b = a.textContent; return b } catch (l) { console.log(l.message) } } var d, e, f, g, h, q, a = !1, b = this, c = function (a) { return a instanceof c ? a : this instanceof c ? (this.EXIFwrapped = a, void 0) : new c(a) }; "undefined" != typeof exports ? ("undefined" != typeof module && module.exports && (exports = module.exports = c), exports.EXIF = c) : b.EXIF = c, d = c.Tags = { 36864: "ExifVersion", 40960: "FlashpixVersion", 40961: "ColorSpace", 40962: "PixelXDimension", 40963: "PixelYDimension", 37121: "ComponentsConfiguration", 37122: "CompressedBitsPerPixel", 37500: "MakerNote", 37510: "UserComment", 40964: "RelatedSoundFile", 36867: "DateTimeOriginal", 36868: "DateTimeDigitized", 37520: "SubsecTime", 37521: "SubsecTimeOriginal", 37522: "SubsecTimeDigitized", 33434: "ExposureTime", 33437: "FNumber", 34850: "ExposureProgram", 34852: "SpectralSensitivity", 34855: "ISOSpeedRatings", 34856: "OECF", 37377: "ShutterSpeedValue", 37378: "ApertureValue", 37379: "BrightnessValue", 37380: "ExposureBias", 37381: "MaxApertureValue", 37382: "SubjectDistance", 37383: "MeteringMode", 37384: "LightSource", 37385: "Flash", 37396: "SubjectArea", 37386: "FocalLength", 41483: "FlashEnergy", 41484: "SpatialFrequencyResponse", 41486: "FocalPlaneXResolution", 41487: "FocalPlaneYResolution", 41488: "FocalPlaneResolutionUnit", 41492: "SubjectLocation", 41493: "ExposureIndex", 41495: "SensingMethod", 41728: "FileSource", 41729: "SceneType", 41730: "CFAPattern", 41985: "CustomRendered", 41986: "ExposureMode", 41987: "WhiteBalance", 41988: "DigitalZoomRation", 41989: "FocalLengthIn35mmFilm", 41990: "SceneCaptureType", 41991: "GainControl", 41992: "Contrast", 41993: "Saturation", 41994: "Sharpness", 41995: "DeviceSettingDescription", 41996: "SubjectDistanceRange", 40965: "InteroperabilityIFDPointer", 42016: "ImageUniqueID" }, e = c.TiffTags = { 256: "ImageWidth", 257: "ImageHeight", 34665: "ExifIFDPointer", 34853: "GPSInfoIFDPointer", 40965: "InteroperabilityIFDPointer", 258: "BitsPerSample", 259: "Compression", 262: "PhotometricInterpretation", 274: "Orientation", 277: "SamplesPerPixel", 284: "PlanarConfiguration", 530: "YCbCrSubSampling", 531: "YCbCrPositioning", 282: "XResolution", 283: "YResolution", 296: "ResolutionUnit", 273: "StripOffsets", 278: "RowsPerStrip", 279: "StripByteCounts", 513: "JPEGInterchangeFormat", 514: "JPEGInterchangeFormatLength", 301: "TransferFunction", 318: "WhitePoint", 319: "PrimaryChromaticities", 529: "YCbCrCoefficients", 532: "ReferenceBlackWhite", 306: "DateTime", 270: "ImageDescription", 271: "Make", 272: "Model", 305: "Software", 315: "Artist", 33432: "Copyright" }, f = c.GPSTags = { 0: "GPSVersionID", 1: "GPSLatitudeRef", 2: "GPSLatitude", 3: "GPSLongitudeRef", 4: "GPSLongitude", 5: "GPSAltitudeRef", 6: "GPSAltitude", 7: "GPSTimeStamp", 8: "GPSSatellites", 9: "GPSStatus", 10: "GPSMeasureMode", 11: "GPSDOP", 12: "GPSSpeedRef", 13: "GPSSpeed", 14: "GPSTrackRef", 15: "GPSTrack", 16: "GPSImgDirectionRef", 17: "GPSImgDirection", 18: "GPSMapDatum", 19: "GPSDestLatitudeRef", 20: "GPSDestLatitude", 21: "GPSDestLongitudeRef", 22: "GPSDestLongitude", 23: "GPSDestBearingRef", 24: "GPSDestBearing", 25: "GPSDestDistanceRef", 26: "GPSDestDistance", 27: "GPSProcessingMethod", 28: "GPSAreaInformation", 29: "GPSDateStamp", 30: "GPSDifferential" }, g = c.IFD1Tags = { 256: "ImageWidth", 257: "ImageHeight", 258: "BitsPerSample", 259: "Compression", 262: "PhotometricInterpretation", 273: "StripOffsets", 274: "Orientation", 277: "SamplesPerPixel", 278: "RowsPerStrip", 279: "StripByteCounts", 282: "XResolution", 283: "YResolution", 284: "PlanarConfiguration", 296: "ResolutionUnit", 513: "JpegIFOffset", 514: "JpegIFByteCount", 529: "YCbCrCoefficients", 530: "YCbCrSubSampling", 531: "YCbCrPositioning", 532: "ReferenceBlackWhite" }, h = c.StringValues = { ExposureProgram: { 0: "Not defined", 1: "Manual", 2: "Normal program", 3: "Aperture priority", 4: "Shutter priority", 5: "Creative program", 6: "Action program", 7: "Portrait mode", 8: "Landscape mode" }, MeteringMode: { 0: "Unknown", 1: "Average", 2: "CenterWeightedAverage", 3: "Spot", 4: "MultiSpot", 5: "Pattern", 6: "Partial", 255: "Other" }, LightSource: { 0: "Unknown", 1: "Daylight", 2: "Fluorescent", 3: "Tungsten (incandescent light)", 4: "Flash", 9: "Fine weather", 10: "Cloudy weather", 11: "Shade", 12: "Daylight fluorescent (D 5700 - 7100K)", 13: "Day white fluorescent (N 4600 - 5400K)", 14: "Cool white fluorescent (W 3900 - 4500K)", 15: "White fluorescent (WW 3200 - 3700K)", 17: "Standard light A", 18: "Standard light B", 19: "Standard light C", 20: "D55", 21: "D65", 22: "D75", 23: "D50", 24: "ISO studio tungsten", 255: "Other" }, Flash: { 0: "Flash did not fire", 1: "Flash fired", 5: "Strobe return light not detected", 7: "Strobe return light detected", 9: "Flash fired, compulsory flash mode", 13: "Flash fired, compulsory flash mode, return light not detected", 15: "Flash fired, compulsory flash mode, return light detected", 16: "Flash did not fire, compulsory flash mode", 24: "Flash did not fire, auto mode", 25: "Flash fired, auto mode", 29: "Flash fired, auto mode, return light not detected", 31: "Flash fired, auto mode, return light detected", 32: "No flash function", 65: "Flash fired, red-eye reduction mode", 69: "Flash fired, red-eye reduction mode, return light not detected", 71: "Flash fired, red-eye reduction mode, return light detected", 73: "Flash fired, compulsory flash mode, red-eye reduction mode", 77: "Flash fired, compulsory flash mode, red-eye reduction mode, return light not detected", 79: "Flash fired, compulsory flash mode, red-eye reduction mode, return light detected", 89: "Flash fired, auto mode, red-eye reduction mode", 93: "Flash fired, auto mode, return light not detected, red-eye reduction mode", 95: "Flash fired, auto mode, return light detected, red-eye reduction mode" }, SensingMethod: { 1: "Not defined", 2: "One-chip color area sensor", 3: "Two-chip color area sensor", 4: "Three-chip color area sensor", 5: "Color sequential area sensor", 7: "Trilinear sensor", 8: "Color sequential linear sensor" }, SceneCaptureType: { 0: "Standard", 1: "Landscape", 2: "Portrait", 3: "Night scene" }, SceneType: { 1: "Directly photographed" }, CustomRendered: { 0: "Normal process", 1: "Custom process" }, WhiteBalance: { 0: "Auto white balance", 1: "Manual white balance" }, GainControl: { 0: "None", 1: "Low gain up", 2: "High gain up", 3: "Low gain down", 4: "High gain down" }, Contrast: { 0: "Normal", 1: "Soft", 2: "Hard" }, Saturation: { 0: "Normal", 1: "Low saturation", 2: "High saturation" }, Sharpness: { 0: "Normal", 1: "Soft", 2: "Hard" }, SubjectDistanceRange: { 0: "Unknown", 1: "Macro", 2: "Close view", 3: "Distant view" }, FileSource: { 3: "DSC" }, Components: { 0: "", 1: "Y", 2: "Cb", 3: "Cr", 4: "R", 5: "G", 6: "B" } }, q = { 120: "caption", 110: "credit", 25: "keywords", 55: "dateCreated", 80: "byline", 85: "bylineTitle", 122: "captionWriter", 105: "headline", 116: "copyright", 15: "category" }, c.enableXmp = function () { c.isXmpEnabled = !0 }, c.disableXmp = function () { c.isXmpEnabled = !1 }, c.getData = function (a, b) { return (self.Image && a instanceof self.Image || self.HTMLImageElement && a instanceof self.HTMLImageElement) && !a.complete ? !1 : (j(a) ? b && b.call(a) : m(a, b), !0) }, c.getTag = function (a, b) { return j(a) ? a.exifdata[b] : void 0 }, c.getIptcTag = function (a, b) { return j(a) ? a.iptcdata[b] : void 0 }, c.getAllTags = function (a) { if (!j(a)) return {}; var b, c = a.exifdata, d = {}; for (b in c) c.hasOwnProperty(b) && (d[b] = c[b]); return d }, c.getAllIptcTags = function (a) { if (!j(a)) return {}; var b, c = a.iptcdata, d = {}; for (b in c) c.hasOwnProperty(b) && (d[b] = c[b]); return d }, c.pretty = function (a) { if (!j(a)) return ""; var b, c = a.exifdata, d = ""; for (b in c) c.hasOwnProperty(b) && (d += "object" == typeof c[b] ? c[b] instanceof Number ? b + " : " + c[b] + " [" + c[b].numerator + "/" + c[b].denominator + "]\r\n" : b + " : [" + c[b].length + " values]\r\n" : b + " : " + c[b] + "\r\n"); return d }, c.readFromBinaryFile = function (a) { return o(a) }, "function" == typeof define && define.amd && define("exif-js", [], function () { return c }) }.call(this);


(function () {
  function process(file, options, callback) {
    //判断是否是图片类型
    if (!/image\/\w+/.test(file.type)) {
      upload(file, callback)
      return
    }
    EXIF.getData(file, function () {
      var exif = EXIF.getAllTags(this);
      var reader = new FileReader()
      reader.onload = function (e) {
        var image = new Image();
        image.onload = function () {
          var canvas = document.createElement("canvas");
          var ctx = canvas.getContext("2d");
          var width = this.width;
          var height = this.height;
          if (options && options.maxWidth) {
            var _w = this.width / options.maxWidth;
            if (_w >= 1) { width = options.maxWidth; height = this.height * options.maxWidth / this.width }
          }
          switch (exif.Orientation || 1) {
            case 1:
              canvas.width = width;
              canvas.height = height;
              ctx.drawImage(this, 0, 0);
              break;
            case 6:
              canvas.width = height;
              canvas.height = width;
              ctx.rotate(0.5 * Math.PI)
              ctx.drawImage(this, 0, -canvas.width);
              break;
            case 8:
              canvas.width = width;
              canvas.height = height;
              ctx.rotate(Math.PI)
              ctx.drawImage(this, -canvas.height, -canvas.width);
              break;
            case 3:
              canvas.width = height;
              canvas.height = width;
              ctx.rotate(-0.5 * Math.PI)
              ctx.drawImage(this, 0, canvas.width);
              break;
          }
          upload(canvas.toDataURL('image/png'), callback)
          return
        }
        image.src = this.result;
      }
      reader.readAsDataURL(file)
    })


    function upload(file, options) {
      if (!file) return;
      var outhttp = "http://conimg.yp.yeyimg.com";
      var bucket = "conimg";
      var para = {
        'bucket': bucket,
        'expiration': new Date().getTime() + 60000 * 60,
        'save-key': '/{year}/{mon}/{day}/' + guid() + '.' + file.name.substring(file.name.lastIndexOf('.') + 1).toLowerCase(),
        'x-gmkerl-thumb': '/rotate/auto'
      }
      var policy = base64encode(JSON.stringify(para))
      var formdata = new window.FormData()
      formdata.append('file', file)
      formdata.append('policy', policy)
      $.ajax({
        url: '/Upyun/Signature',
        data: {
          policy: policy
        },
        type: 'POST',
        //async: true,
        success: function (data) {
          formdata.append('signature', data)
          $.ajax({
            url: 'http://v0.api.upyun.com/' + para.bucket + '/',
            data: formdata,
            type: 'POST',
            cache: false,
            //async: true,
            processData: false,
            contentType: false,
            success: function (data) {
              var res = JSON.parse(data);
              var file_url = outhttp + res.url;
              options.success ? options.success(file_url) : function (file_url) { console.log(file_url) }
            },
            error: function (res) {
              options.error ? options.error(res) : function (res) { console.log(res) }
            },
            complete: function () {
              options.complete ? options.complete() : function () { }
            }
          })
        },
        error: function (res) {
          options.error ? options.error(res) : function (res) { console.log(res) }
          options.complete ? options.complete() : function () { }
        }
      })
    }
    function guid() {
      return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
      });
    }
    function base64encode(str) {
      var base64EncodeChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
      var out, i, len
      var c1, c2, c3
      len = str.length
      i = 0
      out = ''
      while (i < len) {
        c1 = str.charCodeAt(i++) & 0xff
        if (i === len) {
          out += base64EncodeChars.charAt(c1 >> 2)
          out += base64EncodeChars.charAt((c1 & 0x3) << 4)
          out += '=='
          break
        }
        c2 = str.charCodeAt(i++)
        if (i === len) {
          out += base64EncodeChars.charAt(c1 >> 2)
          out += base64EncodeChars.charAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4))
          out += base64EncodeChars.charAt((c2 & 0xF) << 2)
          out += '='
          break
        }
        c3 = str.charCodeAt(i++)
        out += base64EncodeChars.charAt(c1 >> 2)
        out += base64EncodeChars.charAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4))
        out += base64EncodeChars.charAt(((c2 & 0xF) << 2) | ((c3 & 0xC0) >> 6))
        out += base64EncodeChars.charAt(c3 & 0x3F)
      }
      return out
    }

    $.upload = function (file, options) {
      $.extend(file, { maxWidth: 640 }, options)
    }
  }
})()