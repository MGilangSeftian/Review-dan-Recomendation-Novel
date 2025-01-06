import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class TampilanCamera extends StatefulWidget {
  const TampilanCamera({super.key});

  @override
  State<TampilanCamera> createState() => _CameraWebPageState();
}

class _CameraWebPageState extends State<TampilanCamera> {
  late html.VideoElement _videoElement;
  late html.CanvasElement _canvasElement;
  late html.CanvasRenderingContext2D _context;
  bool _kamerasiap = false;
  bool _kameraerror = false;
  late String _capturedImageUrl;
  html.MediaStream? _currentStream;
  late final String _viewType;

  @override
  void initState() {
    super.initState();
    _viewType = 'videoElement_${DateTime.now().millisecondsSinceEpoch}';

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      _viewType,
          (int viewId) => _videoElement,
    );

    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _videoElement = html.VideoElement()
      ..autoplay = true
      ..width = 640
      ..height = 480;

    _canvasElement = html.CanvasElement(width: 640, height: 480);
    _context = _canvasElement.getContext('2d') as html.CanvasRenderingContext2D;

    try {
      _stopCurrentStream();
      final stream = await html.window.navigator.mediaDevices!.getUserMedia({
        'video': true,
        'audio': false,
      });

      _currentStream = stream;
      _videoElement.srcObject = stream;

      _videoElement.onPlaying.listen((event) {
        if (mounted) {
          setState(() {
            _kamerasiap = true;
            _kameraerror = false;
          });
        }
      });

      _videoElement.onError.listen((event) {
        if (mounted) {
          setState(() {
            _kameraerror = true;
          });
        }
      });
    } catch (e) {
      setState(() {
        _kameraerror = true;
      });
    }
  }

  void _stopCurrentStream() {
    if (_currentStream != null) {
      _currentStream?.getTracks().forEach((track) {
        track.stop();
      });
      _currentStream = null;
    }
  }
  void _captureFrame() {
    if (_kamerasiap) {
      _context.clearRect(0, 0, _canvasElement.width!, _canvasElement.height!);
      _context.drawImage(_videoElement, 0, 0);

      setState(() {
        _capturedImageUrl = _canvasElement.toDataUrl('image/png');
      });

      _stopCurrentStream();
      Navigator.pop(context, _capturedImageUrl);
    }
  }

  @override
  void dispose() {
    _stopCurrentStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera Web"),
        backgroundColor: Colors.indigo,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Video Camera
            SizedBox(
              width: 640,
              height: 480,
              child: HtmlElementView(viewType: _viewType),
            ),
            Positioned(
              bottom: 1,
              child: ElevatedButton(
                onPressed: _kamerasiap ? _captureFrame : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo
                ),
                  child: const Text("Ambil Gambar",
                    style: TextStyle(color: Colors.white),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
