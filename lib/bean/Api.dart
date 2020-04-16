class Api {
  // ignore: non_constant_identifier_names
  static final String HOST = "https://www.wanandroid.com/";

  // 轮播图
  // ignore: non_constant_identifier_names
  static final String BANNER_LIST = HOST + "banner/json";

  //首页数据
  // ignore: non_constant_identifier_names
  static final String HOME_LIST = HOST + "article/list/";

  //热门搜索==>http://www.wanandroid.com/hotkey/json
  // ignore: non_constant_identifier_names
  static final String HOT_WORD = HOST + "hotkey/json";

  // ignore: non_constant_identifier_names
  static final String HOT_FRIEND = HOST + "friend/json";

  //搜索
  // ignore: non_constant_identifier_names
  static final String SEARCH_WORD = HOST + "article/query/";

  //知识体系http://www.wanandroid.com/tree/json
  // ignore: non_constant_identifier_names
  static final String KNOWLEDGE_TREE = HOST + "tree/json";

  //具体标签下的文章http://www.wanandroid.com/article/list/0/json?cid=168
  // ignore: non_constant_identifier_names
  static final String KNOWLEDGE_LIST = HOST + "article/list/";

  //项目http://www.wanandroid.com/project/tree/json
  // ignore: non_constant_identifier_names
  static final String PROJECT_TREE = HOST + "project/tree/json";

  //项目列表http://www.wanandroid.com/project/list/1/json?cid=294
  // ignore: non_constant_identifier_names
  static final String PROJECT_LIST = HOST + "project/list/";

  //收藏列表https://www.wanandroid.com/lg/collect/list/0/json
  // ignore: non_constant_identifier_names
  static final COLLECT_LIST = "lg/collect/list/";

  //收藏https://www.wanandroid.com/lg/collect/1165/json
  // ignore: non_constant_identifier_names
  static final COLLECT = "lg/collect/";

  //取消收藏 (文章列表)https://www.wanandroid.com/lg/uncollect_originId/2333/json
  // ignore: non_constant_identifier_names
  static final UN_COLLECT_ORIGIN_ID = "lg/uncollect_originId/";

  //取消收藏（我的收藏）https://www.wanandroid.com/lg/uncollect/2805/json
  // ignore: non_constant_identifier_names
  static final UN_COLLECT = "lg/uncollect/";

  //注册 https://www.wanandroid.com/user/register
  // ignore: non_constant_identifier_names
  static final String REGISTER = HOST + "user/register";

  //登录 https://www.wanandroid.com/user/login
  // ignore: non_constant_identifier_names
  static final String LOGIN = HOST + "user/login";

  //退出登录 https://www.wanandroid.com/user/logout/json
  /**
   * 访问了 logout 后，服务端会让客户端清除 Cookie（即cookie max-Age=0），
   * 如果客户端 Cookie 实现合理，可以实现自动清理，如果本地做了用户账号密码和保存，及时清理。
   */
  // ignore: non_constant_identifier_names
  static final String LOGOUT = HOST + "user/logout/json";
}
