
import 'dart:typed_data';

import 'package:video_compress/video_compress.dart';

import 'log_util.dart';

/// 视频工具类
class VideoUtil {

  /// 压缩视频
  /// [path] 原文件地址
  /// [maxSize] 最大尺寸,单位M
  /// 1M = 1024 * 1024 bytes
  static Future<Uint8List?> compressVideo(String? path, double maxSize) async {
    if (path == null) return null;

    MediaInfo? mediaInfo = await VideoCompress.compressVideo(
      path,
      quality: VideoQuality.DefaultQuality,
      deleteOrigin: false,
    );
    if (mediaInfo != null) {
      int fileSize = mediaInfo.filesize ?? 0;
      if (fileSize > maxSize * 1024 * 1024) {// 再次尝试压缩一下
        LogUtil.loggerLevelD("compressVideo 尺寸超限，再次压缩");
        mediaInfo = await VideoCompress.compressVideo(
          path,
          quality: VideoQuality.LowQuality,
          deleteOrigin: true,
        );
      }
      if (mediaInfo != null) {
        Uint8List? video = await mediaInfo.file?.readAsBytes();
        LogUtil.loggerLevelD("compressVideo 返回数据，尺寸：${mediaInfo.filesize}");
        return video;
      }
    }
    return null;
  }

}