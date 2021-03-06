import 'package:Fg/model/search_user_entity.dart';
import 'package:Fg/model/trend_entity.dart';
import 'package:Fg/model/branch_entity.dart';
import 'package:Fg/model/user_entity.dart';
import 'package:Fg/model/repos_entity.dart';
import 'package:Fg/model/user_repos_entity.dart';
import 'package:Fg/model/star_entity.dart';
import 'package:Fg/model/search_repos_entity.dart';
import 'package:Fg/model/repos_user_entity.dart';
import 'package:Fg/model/trees_entity.dart';
import 'package:Fg/model/contributions_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "SearchUserEntity") {
      return SearchUserEntity.fromJson(json) as T;
    } else if (T.toString() == "TrendEntity") {
      return TrendEntity.fromJson(json) as T;
    } else if (T.toString() == "BranchEntity") {
      return BranchEntity.fromJson(json) as T;
    } else if (T.toString() == "UserEntity") {
      return UserEntity.fromJson(json) as T;
    } else if (T.toString() == "ReposEntity") {
      return ReposEntity.fromJson(json) as T;
    } else if (T.toString() == "UserReposEntity") {
      return UserReposEntity.fromJson(json) as T;
    } else if (T.toString() == "StarEntity") {
      return StarEntity.fromJson(json) as T;
    } else if (T.toString() == "SearchReposEntity") {
      return SearchReposEntity.fromJson(json) as T;
    } else if (T.toString() == "ReposUserEntity") {
      return ReposUserEntity.fromJson(json) as T;
    } else if (T.toString() == "TreesEntity") {
      return TreesEntity.fromJson(json) as T;
    } else if (T.toString() == "ContributionsEntity") {
      return ContributionsEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}