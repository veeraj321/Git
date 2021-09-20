

  import 'package:scrum_poker/widgets/functional/navigation/router_config.dart';

/// routeToWidget takens in an incoming url and finds an appropriate route mapping to 
  /// delete the route to. a template route sile routerMap is  required to use this function
  /// an example of routerMap is provided below 
  /// ```dart
  /// routes = {
  ///     "/":(pathParameters,queryParameters)
  ///             { 
  ///               return MaterialPageRoute((context)=>HomeWidget({type:queryParameters["type"]}));
  ///             },
  ///     "/home/:id/documents/:documentId":(pathParameters,queryParameters)=>print("second route called")
  ///     };
class NavigationUtil {

static RouteConfig resolveRouteToWidget(String route,Map<String,dynamic> routerMap){
    var urlsegments =route.split("?"); //split to see if are any query parameters
    Map<String,String> queryParameters=Map<String,String>();
    Map<String,String>pathParameters=Map<String,String>();
  
    var pathSegments = urlsegments[0].split("/");
     bool routeWasFound=false;
     /// needthe index to invoke the callback in the end
    String? matchedRouteKey;
    for(String routeKey in routerMap.keys){
        var keySegments = routeKey.split("/");
        if(keySegments.length != pathSegments.length){
          continue;
        }else{
          //set the route matched to true and turn it to false in case the route match fails 
          bool allPartsOfRoutMatched = true;
          for(var i=0;i<keySegments.length;i++){
            //if the route looks different from the incoming route then clear the map and break
            if(!keySegments[i].startsWith(":") &&  (keySegments[i]!=pathSegments[i])){
                pathParameters.clear();
                 allPartsOfRoutMatched=false;
                break;
            }
            //if the id comes in then extract the key and value;
            if(keySegments[i].startsWith(":")){
                pathParameters[keySegments[i].substring(1)]=pathSegments[i];
            }
          }
          if(allPartsOfRoutMatched){
            //we found the route that was needed , we can break out of iterating through rest of keys
            routeWasFound=true;
            matchedRouteKey  = routeKey;
            break;
          }
        }
    }
      if(routeWasFound == true  && urlsegments.length>1){
      //we found a matching route so split the query parameters as well
       queryParameters=_getQueryParameters(urlsegments[1]);
    }
    matchedRouteKey = matchedRouteKey ?? '/not-found';
    dynamic callBackFunction  = routerMap[matchedRouteKey];
    RouteConfig routeConfig  = RouteConfig(route: route, routeKey: matchedRouteKey,routeCallBackFunction: callBackFunction, isUnknownRoute: (matchedRouteKey == '/not-found'), pathParameters: pathParameters, queryParameters: queryParameters);
    return routeConfig;
}


/// getQueryParameters splits the query paramter string and returns the query parameter map from the string
/// [queryParameterString] must be a string in the html querystring format
/// example: type=summary&rows-per-page=20&page-no=20

static Map<String,String> _getQueryParameters(String queryParameterString){
  
  Map<String,String> queryParametersMap = Map<String,String>();
  var queryParamSegments = queryParameterString.split("&");
  queryParamSegments.forEach((queryParams) {
    //each query is name=value format so split it further on =
    var queryParamParts = queryParams.split("=");
    queryParametersMap[queryParamParts[0]] = queryParamParts[1];

   });
  return queryParametersMap;
}


}
