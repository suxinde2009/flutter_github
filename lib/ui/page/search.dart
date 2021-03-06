import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../generated/i18n.dart';
import '../../res/res.dart';
import '../../top_config.dart';
import '../../delegate/delegate.dart';
import 'package:dio/dio.dart';
import '../../model/model.dart';
import '../widget/widget.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';

/*
 * @Date: 2019-03-13 17:19 
 * @Description TODO
 */

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  TextEditingController _textEditingController = TextEditingController();

  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {});
    gitHubProvide.page = 0;
  }

  int _index = 0;
  bool _order = true;
  List<Map> list = [];

  @override
  Widget build(BuildContext context) {
    List<String> sort = [
      S.of(context).star,
      S.of(context).forks,
      S.of(context).updates,
    ];

    List<String> userSort = [
      S.of(context).follower,
      S.of(context).repository,
      S.of(context).joined,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: dimen40,
          padding: EdgeInsets.only(left: dimen15, right: dimen10),
          alignment: AlignmentDirectional.centerStart,
          decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(dimen3)),
          child: TextField(
            onChanged: (value) {
              gitHubProvide.searchKey = value;
            },
            onSubmitted: (value) {
              // TODO
              gitHubProvide.searchKey = value;
              setState(() {});
            },
            controller: _textEditingController,
            decoration: InputDecoration.collapsed(
              hintText: S.of(context).key,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.language),
          onPressed: () {
            showSearch(context: context, delegate: SearchLanguagesDelegate(1))
                .then((_) {
              // TODO
            });
          },
          tooltip: S.of(context).languages,
        ),
        actions: <Widget>[
          IconButton(
            icon:
                Icon(_order ? Icons.text_rotate_up : Icons.text_rotation_down),
            onPressed: () {
              _order = !_order;
              gitHubProvide.searchOrder = _order ? 'desc' : 'asc';
              if (gitHubProvide.searchKey.isNotEmpty) {
                setState(() {});
              }
              // TODO
            },
            tooltip: S.of(context).order,
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return (_index == 0 ? sort : userSort).map((s) {
                return CheckedPopupMenuItem(
                  checked: s ==
                      (_index == 0
                          ? gitHubProvide.searchReposSort
                          : gitHubProvide.searchUsersSort),
                  value: s,
                  child: Text(s),
                );
              }).toList();
            },
            icon: Icon(Icons.view_week),
            onSelected: (s) {
              if (_index == 0) {
                gitHubProvide.searchReposSort = s;
              } else {
                gitHubProvide.searchUsersSort = s;
              }
              if (gitHubProvide.searchKey.isNotEmpty) {
                setState(() {});
              }
            },
            tooltip: S.of(context).sort,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          onTap: (index) {
            gitHubProvide.searchType = index;
            setState(() {
              _index = index;
              // TODO
            });
          },
          tabs: [
            Tab(
              child: Text('Repositories'),
            ),
            Tab(
              child: Text('Users'),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: gitHubProvide.getSearch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Response response = snapshot.data;
              Map map = response.data;
              if (response.statusCode == 200 && map['items'] != null) {
                list = (map['items'] as List).cast();
                return EasyRefresh(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (_index == 0) {
                        SearchReposItem item =
                            SearchReposItem.fromJson(list[index]);
                        return searchReposItem(context, item);
                      } else {
                        SearchUserItem item =
                            SearchUserItem.fromJson(list[index]);
                        return searchUsersItem(context, item);
                      }
                    },
                    itemCount: list.length,
                  ),
                  onRefresh: (){
                    gitHubProvide.page = 0;
                    _load();
                  },
                  loadMore: (){
                    gitHubProvide.page++;
                    _load();
                  },
                  refreshHeader: MaterialHeader(key: headerKey),
                  refreshFooter: MaterialFooter(key: footerKey),
                );
              }
            } else {
              return Container();
            }
          }
        },
      ),
    );
  }

  _load() async {
    await gitHubProvide.getSearch().then((data) {
      Response response = data;
      Map map = response.data;
      if (response.statusCode == 200 && map['items'] != null) {
        List<Map> loadList = (map['items'] as List).cast();
        setState(() {
          list.addAll(loadList);
        });
      }
    });
  }
}
