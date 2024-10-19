import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

/// Gopeed api: [Get server info](https://docs.gopeed.com/site/openapi/index.html#get-/api/v1/info).
/// method: GET
Future<http.Response> getServerInfo(String host) {
  Uri targetUri = Uri.http(host, "/api/v1/info");

  return http.get(targetUri);
}

Map<String, dynamic>? _buildHttpExtra(
    {String? method, Map<String, String>? header, String? body}) {
  if (method != null || header != null || body != null) {
    Map<String, dynamic> extra = {};

    if (method != null) {
      extra["method"] = method;
    }
    if (header != null) {
      extra["header"] = header;
    }
    if (body != null) {
      extra["body"] = body;
    }
    return extra;
  } else {
    return null;
  }
}

Map<String, dynamic>? _buildTaskOpt(
    {String? fileName,
    String? filePath,
    List<int>? selectFiles,
    int? connections,
    bool? autoTorrent}) {
  if (fileName != null ||
      filePath != null ||
      selectFiles != null ||
      connections != null ||
      autoTorrent != null) {
    Map<String, dynamic> opt = {};
    if (fileName != null) {
      opt["name"] = fileName;
    }
    if (filePath != null) {
      opt["path"] = filePath;
    }
    if (selectFiles != null) {
      opt["selectFiles"] = selectFiles;
    }
    if (connections != null || autoTorrent != null) {
      opt["extra"] = <String, dynamic>{};
      if (connections != null) {
        opt["extra"]["connections"] = connections;
      }
      if (autoTorrent != null) {
        opt["extra"]["autoTorrent"] = autoTorrent;
      }
    }
    return opt;
  } else {
    return null;
  }
}

Map<String, dynamic>? _buildBtExtra({List<String>? trackers}) {
  if (trackers != null) {
    Map<String, dynamic> extra = {};
    extra["trackers"] = trackers;
    return extra;
  } else {
    return null;
  }
}

/// Gopeed api: [Resolve a request](https://docs.gopeed.com/site/openapi/index.html#post-/api/v1/resolve).
/// method: POST
Future<http.Response> resolveAHttpRequest(String host, String fileUrl,
    {String? method,
    Map<String, String>? header,
    String? body,
    Map<String, String>? labels}) {
  Uri targetUri = Uri.http(host, "/api/v1/resolve");

  Map<String, dynamic> payload = {"url": fileUrl};
  if (method != null || header != null || body != null) {
    payload["extra"] =
        _buildHttpExtra(method: method, header: header, body: body);
  }
  if (labels != null) {
    payload["labels"] = labels;
  }

  return http.post(targetUri, body: convert.jsonEncode(payload));
}

/// Gopeed api: [Resolve a request](https://docs.gopeed.com/site/openapi/index.html#post-/api/v1/resolve).
/// method: POST
Future<http.Response> resolveABtRequest(String host, String fileUrl,
    {List<String>? trackers, Map<String, String>? labels}) {
  Uri targetUri = Uri.http(host, "/api/v1/resolve");
  Map<String, dynamic> payload = {"url": fileUrl};
  if (trackers != null) {
    payload["extra"] = _buildBtExtra(trackers: trackers);
  }
  if (labels != null) {
    payload["labels"] = labels;
  }

  return http.post(targetUri, body: convert.jsonEncode(payload));
}

/// Gopeed api: [Get task list](https://docs.gopeed.com/site/openapi/index.html#get-/api/v1/tasks).
/// method: GET
Future<http.Response> getTaskList(String host,
    {List<String>? id, List<String>? status, List<String>? notStatus}) {
  Map<String, dynamic> queryParametersMap = {};
  if (id != null) {
    queryParametersMap["id"] = id;
  }
  if (status != null) {
    queryParametersMap["status"] = status;
  }
  if (notStatus != null) {
    queryParametersMap["notStatus"] = notStatus;
  }

  Uri targetUri = Uri.http(
    host,
    "/api/v1/tasks",
    queryParametersMap,
  );

  return http.get(targetUri);
}

/// Gopeed api: [Create a task](https://docs.gopeed.com/site/openapi/index.html#post-/api/v1/tasks).
/// method: POST
Future<http.Response> createAHttpTask(String host, String ridOrFileUrl,
    {String? fileName,
    String? filePath,
    List<int>? selectFiles,
    int? connections,
    bool? autoTorrent,
    String? method,
    Map<String, String>? header,
    String? body,
    Map<String, String>? labels}) {
  Uri targetUri = Uri.http(host, "/api/v1/tasks");

  Map<String, dynamic> payload;
  if (Uri.tryParse(ridOrFileUrl) == null) {
    // 传入 rid 时的逻辑
    String rid = ridOrFileUrl;
    payload = {"rid": rid};
    if (fileName != null ||
        filePath != null ||
        selectFiles != null ||
        connections != null ||
        autoTorrent != null) {
      payload["opt"] = _buildTaskOpt(
          fileName: fileName,
          filePath: filePath,
          selectFiles: selectFiles,
          connections: connections,
          autoTorrent: autoTorrent);
    }
  } else {
    // 传入 url 时的逻辑
    String fileUrl = ridOrFileUrl;
    payload = {
      "req": {"url": fileUrl}
    };
    if (fileName != null ||
        filePath != null ||
        selectFiles != null ||
        connections != null ||
        autoTorrent != null) {
      payload["opt"] = _buildTaskOpt(
          fileName: fileName,
          filePath: filePath,
          selectFiles: selectFiles,
          connections: connections,
          autoTorrent: autoTorrent);
    }
    if (method != null || header != null || body != null) {
      payload["req"]["extra"] =
          _buildHttpExtra(method: method, header: header, body: body);
    }
    if (labels != null) {
      payload["req"]["labels"] = labels;
    }
  }
  return http.post(targetUri, body: convert.jsonEncode(payload));
}

/// Gopeed api: [Create a task](https://docs.gopeed.com/site/openapi/index.html#post-/api/v1/tasks).
/// method: POST
Future<http.Response> createABtTask(String host, String ridOrFileUrl,
    {String? fileName,
    String? filePath,
    List<int>? selectFiles,
    int? connections,
    bool? autoTorrent,
    List<String>? trackers,
    Map<String, String>? labels}) {
  Uri targetUri = Uri.http(host, "/api/v1/tasks");

  Map<String, dynamic> payload;
  if (Uri.tryParse(ridOrFileUrl) == null) {
    // 传入 rid 时的逻辑
    String rid = ridOrFileUrl;
    payload = {"rid": rid};
    if (fileName != null ||
        filePath != null ||
        selectFiles != null ||
        connections != null ||
        autoTorrent != null) {
      payload["opt"] = _buildTaskOpt(
          fileName: fileName,
          filePath: filePath,
          selectFiles: selectFiles,
          connections: connections,
          autoTorrent: autoTorrent);
    }
  } else {
    // 传入 url 时的逻辑
    String fileUrl = ridOrFileUrl;
    payload = {
      "req": {"url": fileUrl}
    };
    if (fileName != null ||
        filePath != null ||
        selectFiles != null ||
        connections != null ||
        autoTorrent != null) {
      payload["opt"] = _buildTaskOpt(
          fileName: fileName,
          filePath: filePath,
          selectFiles: selectFiles,
          connections: connections,
          autoTorrent: autoTorrent);
    }
    if (trackers != null) {
      payload["req"]["extra"] = _buildBtExtra(trackers: trackers);
    }
    if (labels != null) {
      payload["req"]["labels"] = labels;
    }
  }
  return http.post(targetUri, body: convert.jsonEncode(payload));
}

/// Gopeed api: [Delete tasks](https://docs.gopeed.com/site/openapi/index.html#delete-/api/v1/tasks).
/// method: DELETE
Future<http.Response> deleteTasks(String host,
    {List<String>? id,
    List<String>? status,
    List<String>? notStatus,
    bool? force}) {
  Map<String, dynamic> queryParametersMap = {};
  if (id != null) {
    queryParametersMap["id"] = id;
  }
  if (status != null) {
    queryParametersMap["status"] = status;
  }
  if (notStatus != null) {
    queryParametersMap["notStatus"] = notStatus;
  }
  if (force != null) {
    queryParametersMap["force"] = force;
  }

  Uri targetUri = Uri.http(
    host,
    "/api/v1/tasks",
    queryParametersMap,
  );

  return http.delete(targetUri);
}

/// Gopeed api: [Create a batch of tasks](https://docs.gopeed.com/site/openapi/index.html#post-/api/v1/tasks/batch).
/// method: POST
Future<http.Response> createABatchOfHttpTasks(
    String host, List<String> fileUrlList,
    {String? fileName,
    String? filePath,
    List<int>? selectFiles,
    int? connections,
    bool? autoTorrent,
    List<String>? methodList,
    List<Map<String, String>>? headerList,
    List<String>? bodyList,
    List<Map<String, String>>? labelsList}) {
  Uri targetUri = Uri.http(host, "/api/v1/tasks/batch");

  Map<String, dynamic> payload;
  Map<String, dynamic> reqItem;
  List<Map<String, dynamic>> reqs = [];

  for (int i = 0; i < fileUrlList.length; i++) {
    reqItem = {"url": fileUrlList[i]};

    if (methodList != null || headerList != null || bodyList != null) {
      reqItem["extra"] = _buildHttpExtra(
          method: methodList != null ? methodList[i] : null,
          header: headerList != null ? headerList[i] : null,
          body: bodyList != null ? bodyList[i] : null);
    }
    if (labelsList != null) {
      reqItem["labels"] = labelsList[i];
    }
    reqs.add(reqItem);
  }
  payload = {
    "reqs": reqs,
  };
  if (fileName != null ||
      filePath != null ||
      selectFiles != null ||
      connections != null ||
      autoTorrent != null) {
    payload["opt"] = _buildTaskOpt(
        fileName: fileName,
        filePath: filePath,
        selectFiles: selectFiles,
        connections: connections,
        autoTorrent: autoTorrent);
  }

  return http.post(targetUri, body: convert.jsonEncode(payload));
}

/// Gopeed api: [Create a batch of tasks](https://docs.gopeed.com/site/openapi/index.html#post-/api/v1/tasks/batch).
/// method: POST
Future<http.Response> createABatchOfBtTasks(
    String host, List<String> fileUrlList,
    {String? fileName,
    String? filePath,
    List<int>? selectFiles,
    int? connections,
    bool? autoTorrent,
    List<List<String>>? trackersList,
    List<Map<String, String>>? labelsList}) {
  Uri targetUri = Uri.http(host, "/api/v1/tasks/batch");

  Map<String, dynamic> payload;
  Map<String, dynamic> reqItem;
  List<Map<String, dynamic>> reqs = [];

  for (int i = 0; i < fileUrlList.length; i++) {
    reqItem = {"url": fileUrlList[i]};
    if (trackersList != null) {
      reqItem["extra"] = _buildBtExtra(trackers: trackersList[i]);
    }
    if (labelsList != null) {
      reqItem["labels"] = labelsList[i];
    }
    reqs.add(reqItem);
  }
  payload = {
    "reqs": reqs,
  };
  if (fileName != null ||
      filePath != null ||
      selectFiles != null ||
      connections != null ||
      autoTorrent != null) {
    payload["opt"] = _buildTaskOpt(
        fileName: fileName,
        filePath: filePath,
        selectFiles: selectFiles,
        connections: connections,
        autoTorrent: autoTorrent);
  }

  return http.post(targetUri, body: convert.jsonEncode(payload));
}

/// Gopeed api: [Get task info](https://docs.gopeed.com/site/openapi/index.html#get-/api/v1/tasks/-id-).
/// method: GET
Future<http.Response> getTaskInfo(String host, String id) {
  Uri targetUri = Uri.http(host, "/api/v1/tasks/$id");

  return http.get(targetUri);
}

/// Gopeed api: [Delete a task](https://docs.gopeed.com/site/openapi/index.html#delete-/api/v1/tasks/-id-).
/// method: DELETE
Future<http.Response> deleteATask(String host, String id, {bool? force}) {
  Uri targetUri = Uri.http(
      host, "/api/v1/tasks/$id", force != null ? {"force": force} : null);

  return http.delete(targetUri);
}

/// Gopeed api: [Get task stats](https://docs.gopeed.com/site/openapi/index.html#get-/api/v1/tasks/-id-/stats).
/// method: GET
Future<http.Response> getTaskStats(String host, String id) {
  Uri targetUri = Uri.http(host, "/api/v1/tasks/$id/stats");

  return http.get(targetUri);
}

/// Gopeed api: [Pause a task](https://docs.gopeed.com/site/openapi/index.html#put-/api/v1/tasks/-id-/pause).
/// method: PUT
Future<http.Response> pauseATask(String host, String id) {
  Uri targetUri = Uri.http(host, "/api/v1/tasks/$id/pause");

  return http.put(targetUri);
}

/// Gopeed api: [Pause a batch of tasks](https://docs.gopeed.com/site/openapi/index.html#put-/api/v1/tasks/pause).
/// method: PUT
Future<http.Response> pauseABatchOfTasks(String host,
    {List<String>? id, List<String>? status, List<String>? notStatus}) {
  Map<String, dynamic> queryParametersMap = {};
  if (id != null) {
    queryParametersMap["id"] = id;
  }
  if (status != null) {
    queryParametersMap["status"] = status;
  }
  if (notStatus != null) {
    queryParametersMap["notStatus"] = notStatus;
  }

  Uri targetUri = Uri.http(host, "/api/v1/tasks/pause", queryParametersMap);

  return http.put(targetUri);
}

/// Gopeed api: [Continue a task](https://docs.gopeed.com/site/openapi/index.html#put-/api/v1/tasks/-id-/continue).
/// method: PUT
Future<http.Response> continueATask(String host, String id) {
  Uri targetUri = Uri.http(host, "/api/v1/tasks/$id/continue");

  return http.put(targetUri);
}

/// Gopeed api: [Continue a batch of tasks](https://docs.gopeed.com/site/openapi/index.html#put-/api/v1/tasks/continue).
/// method: PUT
Future<http.Response> continueABatchOfTasks(String host,
    {List<String>? id, List<String>? status, List<String>? notStatus}) {
  Map<String, dynamic> queryParametersMap = {};
  if (id != null) {
    queryParametersMap["id"] = id;
  }
  if (status != null) {
    queryParametersMap["status"] = status;
  }
  if (notStatus != null) {
    queryParametersMap["notStatus"] = notStatus;
  }

  Uri targetUri = Uri.http(host, "/api/v1/tasks/continue", queryParametersMap);

  return http.put(targetUri);
}
