// import 'package:auto_route/auto_route.dart';
// import 'package:flutter_admin/router/menu_guard.dart';
// import 'package:flutter_admin/views/course/list.dart';
// import 'package:flutter_admin/views/index.dart';
// import 'package:flutter_admin/views/login/login.dart';
// import 'package:flutter_admin/views/router_view.dart';
// import 'package:flutter_admin/views/school/list.dart';
// import 'package:flutter_admin/views/user/list.dart';
//
// import '../views/main_body.dart';
//
// @CustomAutoRouter(
//   replaceInRouteName: "Page|View|Body,Route",
//   durationInMilliseconds: 200,
//   transitionsBuilder: TransitionsBuilders.fadeIn,
//
//   routes: <AutoRoute>[
//     AutoRoute(
//       name: 'Login',
//       path: '/login',
//       meta: {
//         'menu': false,
//         'affix': false,
//         'title': '登录',
//         'icon_font': 'MaterialIcons',
//         'icon_data': 0xe048
//       },
//       page: LoginView,
//     ),
//     AutoRoute(
//       name: 'Main',
//       path: '/main',
//       guards: [MenuGuard],
//       page: RouterView,
//       initial: true,
//       meta: {'menu': true, 'affix': false, 'title': '主界面'},
//       children: [
//         AutoRoute(
//             name: 'Index',
//             initial: true,
//             path: 'index',
//             page: IndexView,
//             meta: {'title': '首页'}),
//         AutoRoute(
//             name: 'Permission',
//             path: 'permission',
//             page: MainBody,
//             meta: {
//               'title': '权限管理'
//             },
//             children: [
//               AutoRoute(
//                 name: 'Permission_Role',
//                 path: 'role',
//                 page: LoginView,
//                 meta: {'title': '角色管理'},
//               )
//             ]),
//         AutoRoute(
//           name: 'User',
//           path: 'user',
//           meta: {'title': '用户管理'},
//           page: MainBody,
//           children: [
//             AutoRoute(
//                 name: 'User_List',
//                 page: UserList,
//                 path: 'list',
//                 meta: {'title': '用户列表'})
//           ],
//         ),
//         AutoRoute(
//           name: 'School',
//           path: 'school',
//           page: MainBody,
//           meta: {'title': '学校管理'},
//           children: [
//             AutoRoute(
//                 name: 'School_List',
//                 page: SchoolView,
//                 path: 'list',
//                 meta: {'title': '学校列表'}),
//             AutoRoute(
//                 name: 'School_Major',
//                 page: SchoolView,
//                 path: 'major',
//                 meta: {'title': '专业管理'})
//           ],
//         ),
//         AutoRoute(
//           name: 'Course',
//           path: 'course',
//           page: MainBody,
//           meta: {'title': '课程管理'},
//           children: [
//             AutoRoute(
//                 name: 'Course_List',
//                 page: CourseListPage,
//                 path: 'list',
//                 meta: {'title': '课程列表'}),
//             AutoRoute(
//                 name: 'Course_Type',
//                 page: SchoolView,
//                 path: 'type',
//                 meta: {'title': '课程分类'}),
//             AutoRoute(
//                 name: 'Course_Update',
//                 page: SchoolView,
//                 path: 'update',
//                 meta: {'title': '课程录入'}),
//             AutoRoute(
//                 name: 'Suject_List',
//                 page: SchoolView,
//                 path: 'suject',
//                 meta: {'title': '科目管理'})
//           ],
//         ),
//         AutoRoute(
//           name: 'Transaction',
//           path: 'transaction',
//           page: MainBody,
//           meta: {'title': '交易管理'},
//           children: [
//             AutoRoute(
//                 name: 'Transaction_Order',
//                 page: SchoolView,
//                 path: 'order',
//                 meta: {'title': '商品订单'}),
//             AutoRoute(
//                 name: 'Transaction_Pay_Config',
//                 page: SchoolView,
//                 path: 'pay-config',
//                 meta: {'title': '支付设置'}),
//             AutoRoute(
//                 name: 'Transaction_Refund',
//                 page: SchoolView,
//                 path: 'refund',
//                 meta: {'title': '退款处理'}),
//             AutoRoute(
//                 name: 'Transaction_Log',
//                 page: SchoolView,
//                 path: 'log',
//                 meta: {'title': '交易明细'})
//           ],
//         ),
//         AutoRoute(
//           name: 'Data',
//           path: 'data',
//           page: MainBody,
//           meta: {'title': '数据中心'},
//           children: [
//             AutoRoute(
//                 name: 'Data_Question',
//                 page: SchoolView,
//                 path: 'question',
//                 meta: {'title': '题库'}),
//             AutoRoute(
//                 name: 'Data_Video',
//                 page: SchoolView,
//                 path: 'video',
//                 meta: {'title': '视频库'}),
//             AutoRoute(
//                 name: 'Data_Import_Question',
//                 page: SchoolView,
//                 path: 'question-import',
//                 meta: {'title': '题库导入'}),
//             AutoRoute(
//                 name: 'Data_Import_Video',
//                 page: SchoolView,
//                 path: 'video-import',
//                 meta: {'title': '视频导入'})
//           ],
//         ),
//
//       ],
//     )
//   ],
// )
// class $AppRouter {}
