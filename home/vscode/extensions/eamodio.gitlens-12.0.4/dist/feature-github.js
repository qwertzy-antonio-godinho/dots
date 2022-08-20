var mt=Object.defineProperty;var y=(ae,le)=>mt(ae,"name",{value:le,configurable:!0});exports.id=457;exports.ids=[457];exports.modules={5186:(ae,le,_)=>{var T=_(3698),ie=_(2505),W=_(6417),V=Function.bind,z=V.bind(V);function L(b,he,pe){var A=z(W,null).apply(null,pe?[he,pe]:[he]);b.api={remove:A},b.remove=A,["before","error","after","wrap"].forEach(function(me){var fe=pe?[he,me,pe]:[he,me];b[me]=b.api[me]=z(ie,null).apply(null,fe)})}y(L,"bindApi");function de(){var b="h",he={registry:{}},pe=T.bind(null,he,b);return L(pe,he,b),pe}y(de,"HookSingular");function ge(){var b={registry:{}},he=T.bind(null,b);return L(he,b),he}y(ge,"HookCollection");var Me=!1;function ue(){return Me||(console.warn('[before-after-hook]: "Hook()" repurposing warning, use "Hook.Collection()". Read more: https://git.io/upgrade-before-after-hook-to-1.4'),Me=!0),ge()}y(ue,"Hook"),ue.Singular=de.bind(),ue.Collection=ge.bind(),ae.exports=ue,ae.exports.Hook=ue,ae.exports.Singular=ue.Singular,ae.exports.Collection=ue.Collection},2505:ae=>{ae.exports=le;function le(_,T,ie,W){var V=W;_.registry[ie]||(_.registry[ie]=[]),T==="before"&&(W=y(function(z,L){return Promise.resolve().then(V.bind(null,L)).then(z.bind(null,L))},"hook")),T==="after"&&(W=y(function(z,L){var de;return Promise.resolve().then(z.bind(null,L)).then(function(ge){return de=ge,V(de,L)}).then(function(){return de})},"hook")),T==="error"&&(W=y(function(z,L){return Promise.resolve().then(z.bind(null,L)).catch(function(de){return V(de,L)})},"hook")),_.registry[ie].push({hook:W,orig:V})}y(le,"addHook")},3698:ae=>{ae.exports=le;function le(_,T,ie,W){if(typeof ie!="function")throw new Error("method for before hook must be a function");return W||(W={}),Array.isArray(T)?T.reverse().reduce(function(V,z){return le.bind(null,_,z,V,W)},ie)():Promise.resolve().then(function(){return _.registry[T]?_.registry[T].reduce(function(V,z){return z.hook.bind(null,V,W)},ie)():ie(W)})}y(le,"register")},6417:ae=>{ae.exports=le;function le(_,T,ie){if(!!_.registry[T]){var W=_.registry[T].map(function(V){return V.orig}).indexOf(ie);W!==-1&&_.registry[T].splice(W,1)}}y(le,"removeHook")},8026:(ae,le,_)=>{"use strict";_.r(le),_.d(le,{GitHubApi:()=>re,GitHubPullRequest:()=>Oe,fromCommitFileStatus:()=>gt});function T(){return typeof navigator=="object"&&"userAgent"in navigator?navigator.userAgent:typeof process=="object"&&"version"in process?`Node.js/${process.version.substr(1)} (${process.platform}; ${process.arch})`:"<environment undetectable>"}y(T,"getUserAgent");var ie=_(5186);/*!
 * is-plain-object <https://github.com/jonschlinkert/is-plain-object>
 *
 * Copyright (c) 2014-2017, Jon Schlinkert.
 * Released under the MIT License.
 */function W(l){return Object.prototype.toString.call(l)==="[object Object]"}y(W,"isObject");function V(l){var i,n;return W(l)===!1?!1:(i=l.constructor,i===void 0?!0:(n=i.prototype,!(W(n)===!1||n.hasOwnProperty("isPrototypeOf")===!1)))}y(V,"isPlainObject");function z(l){return l?Object.keys(l).reduce((i,n)=>(i[n.toLowerCase()]=l[n],i),{}):{}}y(z,"lowercaseKeys");function L(l,i){const n=Object.assign({},l);return Object.keys(i).forEach(o=>{V(i[o])?o in l?n[o]=L(l[o],i[o]):Object.assign(n,{[o]:i[o]}):Object.assign(n,{[o]:i[o]})}),n}y(L,"mergeDeep");function de(l){for(const i in l)l[i]===void 0&&delete l[i];return l}y(de,"removeUndefinedProperties");function ge(l,i,n){if(typeof i=="string"){let[s,u]=i.split(" ");n=Object.assign(u?{method:s,url:u}:{url:s},n)}else n=Object.assign({},i);n.headers=z(n.headers),de(n),de(n.headers);const o=L(l||{},n);return l&&l.mediaType.previews.length&&(o.mediaType.previews=l.mediaType.previews.filter(s=>!o.mediaType.previews.includes(s)).concat(o.mediaType.previews)),o.mediaType.previews=o.mediaType.previews.map(s=>s.replace(/-preview/,"")),o}y(ge,"merge");function Me(l,i){const n=/\?/.test(l)?"&":"?",o=Object.keys(i);return o.length===0?l:l+n+o.map(s=>s==="q"?"q="+i.q.split("+").map(encodeURIComponent).join("+"):`${s}=${encodeURIComponent(i[s])}`).join("&")}y(Me,"addQueryParameters");const ue=/\{[^}]+\}/g;function b(l){return l.replace(/^\W+|\W+$/g,"").split(/,/)}y(b,"removeNonChars");function he(l){const i=l.match(ue);return i?i.map(b).reduce((n,o)=>n.concat(o),[]):[]}y(he,"extractUrlVariableNames");function pe(l,i){return Object.keys(l).filter(n=>!i.includes(n)).reduce((n,o)=>(n[o]=l[o],n),{})}y(pe,"omit");function A(l){return l.split(/(%[0-9A-Fa-f]{2})/g).map(function(i){return/%[0-9A-Fa-f]/.test(i)||(i=encodeURI(i).replace(/%5B/g,"[").replace(/%5D/g,"]")),i}).join("")}y(A,"encodeReserved");function me(l){return encodeURIComponent(l).replace(/[!'()*]/g,function(i){return"%"+i.charCodeAt(0).toString(16).toUpperCase()})}y(me,"encodeUnreserved");function fe(l,i,n){return i=l==="+"||l==="#"?A(i):me(i),n?me(n)+"="+i:i}y(fe,"encodeValue");function $(l){return l!=null}y($,"isDefined");function Se(l){return l===";"||l==="&"||l==="?"}y(Se,"isKeyOperator");function ve(l,i,n,o){var s=l[n],u=[];if($(s)&&s!=="")if(typeof s=="string"||typeof s=="number"||typeof s=="boolean")s=s.toString(),o&&o!=="*"&&(s=s.substring(0,parseInt(o,10))),u.push(fe(i,s,Se(i)?n:""));else if(o==="*")Array.isArray(s)?s.filter($).forEach(function(c){u.push(fe(i,c,Se(i)?n:""))}):Object.keys(s).forEach(function(c){$(s[c])&&u.push(fe(i,s[c],c))});else{const c=[];Array.isArray(s)?s.filter($).forEach(function(h){c.push(fe(i,h))}):Object.keys(s).forEach(function(h){$(s[h])&&(c.push(me(h)),c.push(fe(i,s[h].toString())))}),Se(i)?u.push(me(n)+"="+c.join(",")):c.length!==0&&u.push(c.join(","))}else i===";"?$(s)&&u.push(me(n)):s===""&&(i==="&"||i==="?")?u.push(me(n)+"="):s===""&&u.push("");return u}y(ve,"getValues");function ke(l){return{expand:Te.bind(null,l)}}y(ke,"parseUrl");function Te(l,i){var n=["+","#",".","/",";","?","&"];return l.replace(/\{([^\{\}]+)\}|([^\{\}]+)/g,function(o,s,u){if(s){let h="";const f=[];if(n.indexOf(s.charAt(0))!==-1&&(h=s.charAt(0),s=s.substr(1)),s.split(/,/g).forEach(function(p){var C=/([^:\*]*)(?::(\d+)|(\*))?/.exec(p);f.push(ve(i,h,C[1],C[2]||C[3]))}),h&&h!=="+"){var c=",";return h==="?"?c="&":h!=="#"&&(c=h),(f.length!==0?h:"")+f.join(c)}else return f.join(",")}else return A(u)})}y(Te,"expand");function Ge(l){let i=l.method.toUpperCase(),n=(l.url||"/").replace(/:([a-z]\w+)/g,"{$1}"),o=Object.assign({},l.headers),s,u=pe(l,["method","baseUrl","url","headers","request","mediaType"]);const c=he(n);n=ke(n).expand(u),/^http/.test(n)||(n=l.baseUrl+n);const h=Object.keys(l).filter(C=>c.includes(C)).concat("baseUrl"),f=pe(u,h);if(!/application\/octet-stream/i.test(o.accept)&&(l.mediaType.format&&(o.accept=o.accept.split(/,/).map(C=>C.replace(/application\/vnd(\.\w+)(\.v3)?(\.\w+)?(\+json)?$/,`application/vnd$1$2.${l.mediaType.format}`)).join(",")),l.mediaType.previews.length)){const C=o.accept.match(/[\w-]+(?=-preview)/g)||[];o.accept=C.concat(l.mediaType.previews).map(q=>{const Y=l.mediaType.format?`.${l.mediaType.format}`:"+json";return`application/vnd.github.${q}-preview${Y}`}).join(",")}return["GET","HEAD"].includes(i)?n=Me(n,f):"data"in f?s=f.data:Object.keys(f).length?s=f:o["content-length"]=0,!o["content-type"]&&typeof s<"u"&&(o["content-type"]="application/json; charset=utf-8"),["PATCH","PUT"].includes(i)&&typeof s>"u"&&(s=""),Object.assign({method:i,url:n,headers:o},typeof s<"u"?{body:s}:null,l.request?{request:l.request}:null)}y(Ge,"parse");function He(l,i,n){return Ge(ge(l,i,n))}y(He,"endpointWithDefaults");function Ue(l,i){const n=ge(l,i),o=He.bind(null,n);return Object.assign(o,{DEFAULTS:n,defaults:Ue.bind(null,n),merge:ge.bind(null,n),parse:Ge})}y(Ue,"withDefaults");const Ie=`octokit-endpoint.js/6.0.12 ${T()}`,Ve=Ue(null,{method:"GET",baseUrl:"https://api.github.com",headers:{accept:"application/vnd.github.v3+json","user-agent":Ie},mediaType:{format:"",previews:[]}});var ze=_(5568);class Pe extends Error{constructor(i){super(i);Error.captureStackTrace&&Error.captureStackTrace(this,this.constructor),this.name="Deprecation"}}y(Pe,"Deprecation");var We=_(778),Be=_.n(We);const Ae=Be()(l=>console.warn(l)),ne=Be()(l=>console.warn(l));class ee extends Error{constructor(i,n,o){super(i);Error.captureStackTrace&&Error.captureStackTrace(this,this.constructor),this.name="HttpError",this.status=n;let s;"headers"in o&&typeof o.headers<"u"&&(s=o.headers),"response"in o&&(this.response=o.response,s=o.response.headers);const u=Object.assign({},o.request);o.request.headers.authorization&&(u.headers=Object.assign({},o.request.headers,{authorization:o.request.headers.authorization.replace(/ .*$/," [REDACTED]")})),u.url=u.url.replace(/\bclient_secret=\w+/g,"client_secret=[REDACTED]").replace(/\baccess_token=\w+/g,"access_token=[REDACTED]"),this.request=u,Object.defineProperty(this,"code",{get(){return Ae(new Pe("[@octokit/request-error] `error.code` is deprecated, use `error.status`.")),n}}),Object.defineProperty(this,"headers",{get(){return ne(new Pe("[@octokit/request-error] `error.headers` is deprecated, use `error.response.headers`.")),s||{}}})}}y(ee,"RequestError");const R="5.6.3";function ce(l){return l.arrayBuffer()}y(ce,"getBufferResponse");function Fe(l){const i=l.request&&l.request.log?l.request.log:console;(V(l.body)||Array.isArray(l.body))&&(l.body=JSON.stringify(l.body));let n={},o,s;return(l.request&&l.request.fetch||ze.ZP)(l.url,Object.assign({method:l.method,body:l.body,headers:l.headers,redirect:l.redirect},l.request)).then(async c=>{s=c.url,o=c.status;for(const h of c.headers)n[h[0]]=h[1];if("deprecation"in n){const h=n.link&&n.link.match(/<([^>]+)>; rel="deprecation"/),f=h&&h.pop();i.warn(`[@octokit/request] "${l.method} ${l.url}" is deprecated. It is scheduled to be removed on ${n.sunset}${f?`. See ${f}`:""}`)}if(!(o===204||o===205)){if(l.method==="HEAD"){if(o<400)return;throw new ee(c.statusText,o,{response:{url:s,status:o,headers:n,data:void 0},request:l})}if(o===304)throw new ee("Not modified",o,{response:{url:s,status:o,headers:n,data:await Re(c)},request:l});if(o>=400){const h=await Re(c);throw new ee(Ye(h),o,{response:{url:s,status:o,headers:n,data:h},request:l})}return Re(c)}}).then(c=>({status:o,url:s,headers:n,data:c})).catch(c=>{throw c instanceof ee?c:new ee(c.message,500,{request:l})})}y(Fe,"fetchWrapper");async function Re(l){const i=l.headers.get("content-type");return/application\/json/.test(i)?l.json():!i||/^text\/|charset=utf-8$/.test(i)?l.text():ce(l)}y(Re,"getResponseData");function Ye(l){return typeof l=="string"?l:"message"in l?Array.isArray(l.errors)?`${l.message}: ${l.errors.map(JSON.stringify).join(", ")}`:l.message:`Unknown error: ${JSON.stringify(l)}`}y(Ye,"toErrorMessage");function qe(l,i){const n=l.defaults(i);return Object.assign(y(function(s,u){const c=n.merge(s,u);if(!c.request||!c.request.hook)return Fe(n.parse(c));const h=y((f,p)=>Fe(n.parse(n.merge(f,p))),"request");return Object.assign(h,{endpoint:n,defaults:qe.bind(null,n)}),c.request.hook(h,c)},"newApi"),{endpoint:n,defaults:qe.bind(null,n)})}y(qe,"dist_web_withDefaults");const w=qe(Ve,{headers:{"user-agent":`octokit-request.js/${R} ${T()}`}}),Je="4.8.0";function G(l){return`Request failed due to following response errors:
`+l.errors.map(i=>` - ${i.message}`).join(`
`)}y(G,"_buildMessageForResponseErrors");class e extends Error{constructor(i,n,o){super(G(o));this.request=i,this.headers=n,this.response=o,this.name="GraphqlResponseError",this.errors=o.errors,this.data=o.data,Error.captureStackTrace&&Error.captureStackTrace(this,this.constructor)}}y(e,"GraphqlResponseError");const t=["method","baseUrl","url","headers","request","query","mediaType"],r=["query","method","url"],a=/\/api\/v3\/?$/;function g(l,i,n){if(n){if(typeof i=="string"&&"query"in n)return Promise.reject(new Error('[@octokit/graphql] "query" cannot be used as variable name'));for(const c in n)if(!!r.includes(c))return Promise.reject(new Error(`[@octokit/graphql] "${c}" cannot be used as variable name`))}const o=typeof i=="string"?Object.assign({query:i},n):i,s=Object.keys(o).reduce((c,h)=>t.includes(h)?(c[h]=o[h],c):(c.variables||(c.variables={}),c.variables[h]=o[h],c),{}),u=o.baseUrl||l.endpoint.DEFAULTS.baseUrl;return a.test(u)&&(s.url=u.replace(a,"/api/graphql")),l(s).then(c=>{if(c.data.errors){const h={};for(const f of Object.keys(c.headers))h[f]=c.headers[f];throw new e(s,h,c.data)}return c.data.data})}y(g,"graphql");function d(l,i){const n=l.defaults(i);return Object.assign(y((s,u)=>g(n,s,u),"newApi"),{defaults:d.bind(null,n),endpoint:w.endpoint})}y(d,"graphql_dist_web_withDefaults");const v=d(w,{headers:{"user-agent":`octokit-graphql.js/${Je} ${T()}`},method:"POST",url:"/graphql"});function m(l){return d(l,{method:"POST",url:"/graphql"})}y(m,"withCustomRequest");const S=/^v1\./,M=/^ghs_/,E=/^ghu_/;async function F(l){const i=l.split(/\./).length===3,n=S.test(l)||M.test(l),o=E.test(l);return{type:"token",token:l,tokenType:i?"app":n?"installation":o?"user-to-server":"oauth"}}y(F,"auth");function D(l){return l.split(/\./).length===3?`bearer ${l}`:`token ${l}`}y(D,"withAuthorizationPrefix");async function N(l,i,n,o){const s=i.endpoint.merge(n,o);return s.headers.authorization=D(l),i(s)}y(N,"hook");const J=y(function(i){if(!i)throw new Error("[@octokit/auth-token] No token passed to createTokenAuth");if(typeof i!="string")throw new Error("[@octokit/auth-token] Token passed to createTokenAuth is not a string");return i=i.replace(/^(token|bearer) +/i,""),Object.assign(F.bind(null,i),{hook:N.bind(null,i)})},"createTokenAuth"),x="3.5.1";class U{constructor(i={}){const n=new ie.Collection,o={baseUrl:w.endpoint.DEFAULTS.baseUrl,headers:{},request:Object.assign({},i.request,{hook:n.bind(null,"request")}),mediaType:{previews:[],format:""}};if(o.headers["user-agent"]=[i.userAgent,`octokit-core.js/${x} ${T()}`].filter(Boolean).join(" "),i.baseUrl&&(o.baseUrl=i.baseUrl),i.previews&&(o.mediaType.previews=i.previews),i.timeZone&&(o.headers["time-zone"]=i.timeZone),this.request=w.defaults(o),this.graphql=m(this.request).defaults(o),this.log=Object.assign({debug:()=>{},info:()=>{},warn:console.warn.bind(console),error:console.error.bind(console)},i.log),this.hook=n,i.authStrategy){const{authStrategy:u,...c}=i,h=u(Object.assign({request:this.request,log:this.log,octokit:this,octokitOptions:c},i.auth));n.wrap("request",h.hook),this.auth=h}else if(!i.auth)this.auth=async()=>({type:"unauthenticated"});else{const u=J(i.auth);n.wrap("request",u.hook),this.auth=u}this.constructor.plugins.forEach(u=>{Object.assign(this,u(this,i))})}static defaults(i){return y(class extends this{constructor(...o){const s=o[0]||{};if(typeof i=="function"){super(i(s));return}super(Object.assign({},i,s,s.userAgent&&i.userAgent?{userAgent:`${s.userAgent} ${i.userAgent}`}:null))}},"OctokitWithDefaults")}static plugin(...i){var n;const o=this.plugins;return n=y(class extends this{},"_a"),n.plugins=o.concat(i.filter(u=>!o.includes(u))),n}}y(U,"Octokit"),U.VERSION=x,U.plugins=[];var O=_(9496),B=_(1149),P=_(4673),j=_(9179),Z=_(5396),H=_(5059),X=_(2833),k=_(2436),Q=_(7369),be=_(9417),xe=Object.defineProperty,ye=Object.defineProperties,ut=Object.getOwnPropertyDescriptor,ct=Object.getOwnPropertyDescriptors,Le=Object.getOwnPropertySymbols,Ze=Object.prototype.hasOwnProperty,Ke=Object.prototype.propertyIsEnumerable,Xe=y((l,i,n)=>i in l?xe(l,i,{enumerable:!0,configurable:!0,writable:!0,value:n}):l[i]=n,"__defNormalProp"),_e=y((l,i)=>{for(var n in i||(i={}))Ze.call(i,n)&&Xe(l,n,i[n]);if(Le)for(var n of Le(i))Ke.call(i,n)&&Xe(l,n,i[n]);return l},"__spreadValues"),De=y((l,i)=>ye(l,ct(i)),"__spreadProps"),dt=y((l,i)=>{var n={};for(var o in l)Ze.call(l,o)&&i.indexOf(o)<0&&(n[o]=l[o]);if(l!=null&&Le)for(var o of Le(l))i.indexOf(o)<0&&Ke.call(l,o)&&(n[o]=l[o]);return n},"__objRest"),oe=y((l,i,n,o)=>{for(var s=o>1?void 0:o?ut(i,n):i,u=l.length-1,c;u>=0;u--)(c=l[u])&&(s=(o?c(i,n,s):c(s))||s);return o&&s&&xe(i,n,s),s},"__decorateClass"),Ne=y((l,i,n)=>(Xe(l,typeof i!="symbol"?i+"":i,n),n),"__publicField");const Ce=Object.freeze({values:[]}),et=Object.freeze({ranges:[]});class re{constructor(i){Ne(this,"_onDidReauthenticate",new O.EventEmitter),Ne(this,"_disposable"),Ne(this,"_proxyAgent",null),Ne(this,"_octokits",new Map),!P.$L&&(this._disposable=O.Disposable.from(j.DN.onDidChange(n=>{j.DN.changed(n,"proxy")?(this._proxyAgent=null,this._octokits.clear()):j.DN.changed(n,"outputLevel")&&this._octokits.clear()}),j.DN.onDidChangeAny(n=>{(n.affectsConfiguration("http.proxy")||n.affectsConfiguration("http.proxyStrictSSL"))&&(this._proxyAgent=null,this._octokits.clear())})))}get onDidReauthenticate(){return this._onDidReauthenticate.event}dispose(){var i;(i=this._disposable)==null||i.dispose()}get proxyAgent(){if(!P.$L)return this._proxyAgent===null&&(this._proxyAgent=(0,B.N)()),this._proxyAgent}async getAccountForCommit(i,n,o,s,u,c){var h,f;const p=k.Y.getCorrelationContext();try{const C=`query getAccountForCommit(
	$owner: String!
	$repo: String!
	$ref: GitObjectID!
	$avatarSize: Int
) {
	repository(name: $repo, owner: $owner) {
		object(oid: $ref) {
			... on Commit {
				author {
					name
					email
					avatarUrl(size: $avatarSize)
				}
			}
		}
	}
}`,q=await this.graphql(n,C,De(_e({},c),{owner:o,repo:s,ref:u})),Y=(f=(h=q?.repository)==null?void 0:h.object)==null?void 0:f.author;return Y==null?void 0:{provider:i,name:Y.name??void 0,email:Y.email??void 0,avatarUrl:Y.avatarUrl}}catch(C){return this.handleException(C,p,void 0)}}async getAccountForEmail(i,n,o,s,u,c){var h,f;const p=k.Y.getCorrelationContext();try{const C=`query getAccountForEmail(
	$emailQuery: String!
	$avatarSize: Int
) {
	search(type: USER, query: $emailQuery, first: 1) {
		nodes {
			... on User {
				name
				email
				avatarUrl(size: $avatarSize)
			}
		}
	}
}`,q=await this.graphql(n,C,De(_e({},c),{owner:o,repo:s,emailQuery:`in:email ${u}`})),Y=(f=(h=q?.search)==null?void 0:h.nodes)==null?void 0:f[0];return Y==null?void 0:{provider:i,name:Y.name??void 0,email:Y.email??void 0,avatarUrl:Y.avatarUrl}}catch(C){return this.handleException(C,p,void 0)}}async getDefaultBranch(i,n,o,s,u){var c,h;const f=k.Y.getCorrelationContext();try{const p=`query getDefaultBranch(
	$owner: String!
	$repo: String!
) {
	repository(name: $repo, owner: $owner) {
		defaultBranchRef {
			name
		}
	}
}`,C=await this.graphql(n,p,De(_e({},u),{owner:o,repo:s})),q=((h=(c=C?.repository)==null?void 0:c.defaultBranchRef)==null?void 0:h.name)??void 0;return q==null?void 0:{provider:i,name:q}}catch(p){return this.handleException(p,f,void 0)}}async getIssueOrPullRequest(i,n,o,s,u,c){var h;const f=k.Y.getCorrelationContext();try{const p=`query getIssueOrPullRequest(
		$owner: String!
		$repo: String!
		$number: Int!
	) {
		repository(name: $repo, owner: $owner) {
			issueOrPullRequest(number: $number) {
				__typename
				... on Issue {
					createdAt
					closed
					closedAt
					title
					url
				}
				... on PullRequest {
					createdAt
					closed
					closedAt
					title
					url
				}
			}
		}
	}`,C=await this.graphql(n,p,De(_e({},c),{owner:o,repo:s,number:u})),q=(h=C?.repository)==null?void 0:h.issueOrPullRequest;return q==null?void 0:{provider:i,type:q.type,id:String(u),date:new Date(q.createdAt),title:q.title,closed:q.closed,closedDate:q.closedAt==null?void 0:new Date(q.closedAt),url:q.url}}catch(p){return this.handleException(p,f,void 0)}}async getPullRequestForBranch(i,n,o,s,u,c){var h,f,p,C;const q=k.Y.getCorrelationContext();try{const Y=`query getPullRequestForBranch(
	$owner: String!
	$repo: String!
	$branch: String!
	$limit: Int!
	$include: [PullRequestState!]
	$avatarSize: Int
) {
	repository(name: $repo, owner: $owner) {
		refs(query: $branch, refPrefix: "refs/heads/", first: 1) {
			nodes {
				associatedPullRequests(first: $limit, orderBy: {field: UPDATED_AT, direction: DESC}, states: $include) {
					nodes {
						author {
							login
							avatarUrl(size: $avatarSize)
							url
						}
						permalink
						number
						title
						state
						updatedAt
						closedAt
						mergedAt
						repository {
							isFork
							owner {
								login
							}
						}
					}
				}
			}
		}
	}
}`,K=await this.graphql(n,Y,De(_e({},c),{owner:o,repo:s,branch:u,limit:10})),I=(C=(p=(f=(h=K?.repository)==null?void 0:h.refs.nodes[0])==null?void 0:f.associatedPullRequests)==null?void 0:p.nodes)==null?void 0:C.filter(te=>!te.repository.isFork||te.repository.owner.login===o);return I==null||I.length===0?void 0:(I.length>1&&I.sort((te,se)=>(te.repository.owner.login===o?-1:1)-(se.repository.owner.login===o?-1:1)||(te.state==="OPEN"?-1:1)-(se.state==="OPEN"?-1:1)||new Date(se.updatedAt).getTime()-new Date(te.updatedAt).getTime()),Oe.from(I[0],i))}catch(Y){return this.handleException(Y,q,void 0)}}async getPullRequestForCommit(i,n,o,s,u,c){var h,f,p,C;const q=k.Y.getCorrelationContext();try{const Y=`query getPullRequestForCommit(
	$owner: String!
	$repo: String!
	$ref: GitObjectID!
	$avatarSize: Int
) {
	repository(name: $repo, owner: $owner) {
		object(oid: $ref) {
			... on Commit {
				associatedPullRequests(first: 2, orderBy: {field: UPDATED_AT, direction: DESC}) {
					nodes {
						author {
							login
							avatarUrl(size: $avatarSize)
							url
						}
						permalink
						number
						title
						state
						updatedAt
						closedAt
						mergedAt
						repository {
							isFork
							owner {
								login
							}
						}
					}
				}
			}
		}
	}
}`,K=await this.graphql(n,Y,De(_e({},c),{owner:o,repo:s,ref:u})),I=(C=(p=(f=(h=K?.repository)==null?void 0:h.object)==null?void 0:f.associatedPullRequests)==null?void 0:p.nodes)==null?void 0:C.filter(te=>!te.repository.isFork||te.repository.owner.login===o);return I==null||I.length===0?void 0:(I.length>1&&I.sort((te,se)=>(te.repository.owner.login===o?-1:1)-(se.repository.owner.login===o?-1:1)||(te.state==="OPEN"?-1:1)-(se.state==="OPEN"?-1:1)||new Date(se.updatedAt).getTime()-new Date(te.updatedAt).getTime()),Oe.from(I[0],i))}catch(Y){return this.handleException(Y,q,void 0)}}async getBlame(i,n,o,s,u){var c,h,f,p,C;const q=k.Y.getCorrelationContext();try{const Y=`query getBlameRanges(
	$owner: String!
	$repo: String!
	$ref: String!
	$path: String!
) {
	viewer { name }
	repository(owner: $owner, name: $repo) {
		object(expression: $ref) {
			...on Commit {
				blame(path: $path) {
					ranges {
						startingLine
						endingLine
						commit {
							oid
							parents(first: 3) { nodes { oid } }
							message
							additions
							changedFiles
							deletions
							author {
								avatarUrl
								date
								email
								name
							}
							committer {
								date
								email
								name
							}
						}
					}
				}
			}
		}
	}
}`,K=await this.graphql(i,Y,{owner:n,repo:o,ref:s,path:u});if(K==null)return et;const I=(f=(h=(c=K.repository)==null?void 0:c.object)==null?void 0:h.blame)==null?void 0:f.ranges;return I==null||I.length===0?{ranges:[],viewer:(p=K.viewer)==null?void 0:p.name}:{ranges:I,viewer:(C=K.viewer)==null?void 0:C.name}}catch(Y){return this.handleException(Y,q,et)}}async getBranches(i,n,o,s){var u;const c=k.Y.getCorrelationContext();try{const h=`query getBranches(
	$owner: String!
	$repo: String!
	$branchQuery: String
	$cursor: String
	$limit: Int = 100
) {
	repository(owner: $owner, name: $repo) {
		refs(query: $branchQuery, refPrefix: "refs/heads/", first: $limit, after: $cursor, orderBy: { field: TAG_COMMIT_DATE, direction: DESC }) {
			pageInfo {
				endCursor
				hasNextPage
			}
			nodes {
				name
				target {
					oid
					commitUrl
					...on Commit {
						authoredDate
						committedDate
					}
				}
			}
		}
	}
}`,f=await this.graphql(i,h,{owner:n,repo:o,branchQuery:s?.query,cursor:s?.cursor,limit:Math.min(100,s?.limit??100)});if(f==null)return Ce;const p=(u=f.repository)==null?void 0:u.refs;return p==null?Ce:{paging:{cursor:p.pageInfo.endCursor,more:p.pageInfo.hasNextPage},values:p.nodes}}catch(h){return this.handleException(h,c,Ce)}}async getCommit(i,n,o,s){var u,c,h,f,p,C,q,Y,K,I;const te=k.Y.getCorrelationContext();try{const se=await this.request(i,"GET /repos/{owner}/{repo}/commits/{ref}",{owner:n,repo:o,ref:s}),we=se?.data;if(we==null)return;const{commit:$e}=we;return{oid:we.sha,parents:{nodes:we.parents.map(je=>({oid:je.sha}))},message:$e.message,additions:(u=we.stats)==null?void 0:u.additions,changedFiles:(c=we.files)==null?void 0:c.length,deletions:(h=we.stats)==null?void 0:h.deletions,author:{avatarUrl:((f=we.author)==null?void 0:f.avatar_url)??void 0,date:((p=$e.author)==null?void 0:p.date)??new Date().toString(),email:((C=$e.author)==null?void 0:C.email)??void 0,name:((q=$e.author)==null?void 0:q.name)??""},committer:{date:((Y=$e.committer)==null?void 0:Y.date)??new Date().toString(),email:((K=$e.committer)==null?void 0:K.email)??void 0,name:((I=$e.committer)==null?void 0:I.name)??""},files:we.files}}catch(se){return this.handleException(se,te,void 0)}}async getCommitForFile(i,n,o,s,u){if(X.GitRevision.isSha(s))return this.getCommit(i,n,o,s);const c=await this.getCommits(i,n,o,s,{limit:1,path:u});if(c.values.length===0)return;const h=await this.getCommit(i,n,o,c.values[0].oid);return De(_e({},h??c.values[0]),{viewer:c.viewer})}async getCommitBranches(i,n,o,s,u){var c,h;const f=k.Y.getCorrelationContext();try{const p=`query getCommitBranches(
	$owner: String!
	$repo: String!
	$since: GitTimestamp!
	$until: GitTimestamp!
) {
	repository(owner: $owner, name: $repo) {
		refs(first: 20, refPrefix: "refs/heads/", orderBy: { field: TAG_COMMIT_DATE, direction: DESC }) {
			nodes {
				name
				target {
					... on Commit {
						history(first: 3, since: $since until: $until) {
							nodes { oid }
						}
					}
				}
			}
		}
	}
}`,C=await this.graphql(i,p,{owner:n,repo:o,since:u.toISOString(),until:u.toISOString()}),q=(h=(c=C?.repository)==null?void 0:c.refs)==null?void 0:h.nodes;if(q==null)return[];const Y=[];for(const K of q)for(const I of K.target.history.nodes)if(I.oid===s){Y.push(K.name);break}return Y}catch(p){return this.handleException(p,f,[])}}async getCommitCount(i,n,o,s){var u,c;const h=k.Y.getCorrelationContext();try{const f=`query getCommitCount(
	$owner: String!
	$repo: String!
	$ref: String!
) {
	repository(owner: $owner, name: $repo) {
		ref(qualifiedName: $ref) {
			target {
				... on Commit {
					history(first: 1) {
						totalCount
					}
				}
			}
		}
	}
}`,p=await this.graphql(i,f,{owner:n,repo:o,ref:s});return(c=(u=p?.repository)==null?void 0:u.ref)==null?void 0:c.target.history.totalCount}catch(f){return this.handleException(f,h,void 0)}}async getCommitOnBranch(i,n,o,s,u,c){var h;const f=k.Y.getCorrelationContext();try{const p=`query getCommitOnBranch(
	$owner: String!
	$repo: String!
	$ref: String!
	$since: GitTimestamp!
	$until: GitTimestamp!
) {
	repository(owner: $owner, name: $repo) {
		ref(qualifiedName: $ref) {
			target {
				... on Commit {
					history(first: 3, since: $since until: $until) {
						nodes { oid }
					}
				}
			}
		}
	}
}`,C=await this.graphql(i,p,{owner:n,repo:o,ref:`refs/heads/${s}`,since:c.toISOString(),until:c.toISOString()}),q=(h=C?.repository)==null?void 0:h.ref.target.history.nodes;if(q==null)return[];const Y=[];for(const K of q)if(K.oid===u){Y.push(s);break}return Y}catch(p){return this.handleException(p,f,[])}}async getCommits(i,n,o,s,u){var c,h,f,p;const C=k.Y.getCorrelationContext();if(u?.limit===1&&u?.path==null)return this.getCommitsCoreSingle(i,n,o,s);try{const q=`query getCommits(
	$owner: String!
	$repo: String!
	$ref: String!
	$path: String
	$author: CommitAuthor
	$after: String
	$before: String
	$limit: Int = 100
	$since: GitTimestamp
	$until: GitTimestamp
) {
	viewer { name }
	repository(name: $repo, owner: $owner) {
		object(expression: $ref) {
			... on Commit {
				history(first: $limit, author: $author, path: $path, after: $after, before: $before, since: $since, until: $until) {
					pageInfo {
						startCursor
						endCursor
						hasNextPage
						hasPreviousPage
					}
					nodes {
						... on Commit {
							oid
							message
							parents(first: 3) { nodes { oid } }
							additions
							changedFiles
							deletions
							author {
								avatarUrl
								date
								email
								name
							}
							committer {
								 date
								 email
								 name
							 }
						}
					}
				}
			}
		}
	}
}`;let Y;if(u?.authors!=null)if(u.authors.length===1){const[te]=u.authors;Y={id:te.id,emails:te.email?[te.email]:void 0}}else{const te=u.authors.filter(se=>se.email).map(se=>se.email);Y=te.length?{emails:te}:void 0}const K=await this.graphql(i,q,{owner:n,repo:o,ref:s,after:u?.after,before:u?.before,path:u?.path,author:Y,limit:Math.min(100,u?.limit??100),since:typeof u?.since=="string"?u?.since:(c=u?.since)==null?void 0:c.toISOString(),until:typeof u?.until=="string"?u?.until:(h=u?.until)==null?void 0:h.toISOString()}),I=(p=(f=K?.repository)==null?void 0:f.object)==null?void 0:p.history;return I==null?Ce:{paging:I.pageInfo.endCursor!=null?{cursor:I.pageInfo.endCursor??void 0,more:I.pageInfo.hasNextPage}:void 0,values:I.nodes,viewer:K?.viewer.name}}catch(q){return this.handleException(q,C,Ce)}}async getCommitsCoreSingle(i,n,o,s){var u;const c=k.Y.getCorrelationContext();try{const h=`query getCommit(
	$owner: String!
	$repo: String!
	$ref: String!
) {
	viewer { name }
	repository(name: $repo owner: $owner) {
		object(expression: $ref) {
			...on Commit {
				oid
				parents(first: 3) { nodes { oid } }
				message
				additions
				changedFiles
				deletions
				author {
					avatarUrl
					date
					email
					name
				}
				committer {
					date
					email
					name
				}
			}
		}
	}
}`,f=await this.graphql(i,h,{owner:n,repo:o,ref:s});if(f==null)return Ce;const p=(u=f.repository)==null?void 0:u.object;return p!=null?{values:[p],viewer:f.viewer.name}:Ce}catch(h){return this.handleException(h,c,Ce)}}async getCommitRefs(i,n,o,s,u){var c,h;const f=k.Y.getCorrelationContext();try{const p=`query getCommitRefs(
	$owner: String!
	$repo: String!
	$ref: String!
	$after: String
	$before: String
	$first: Int
	$last: Int
	$path: String
	$since: GitTimestamp
	$until: GitTimestamp
) {
	repository(name: $repo, owner: $owner) {
		object(expression: $ref) {
			... on Commit {
				history(first: $first, last: $last, path: $path, since: $since, until: $until, after: $after, before: $before) {
					pageInfo { startCursor, endCursor, hasNextPage, hasPreviousPage }
					totalCount
					nodes { oid }
				}
			}
		}
	}
}`,C=await this.graphql(i,p,{owner:n,repo:o,ref:s,path:u?.path,first:u?.first,last:u?.last,after:u?.after,before:u?.before,since:u?.since,until:u?.until}),q=(h=(c=C?.repository)==null?void 0:c.object)==null?void 0:h.history;return q==null?void 0:{pageInfo:q.pageInfo,totalCount:q.totalCount,values:q.nodes}}catch(p){return this.handleException(p,f,void 0)}}async getNextCommitRefs(i,n,o,s,u,c){const h=await this.getCommitDate(i,n,o,c);if(h==null)return[];let f=await this.getCommitRefs(i,n,o,s,{path:u,first:1,since:h});if(f==null)return[];const p=`${f.pageInfo.startCursor.split(" ",1)[0]} ${f.totalCount}`;let C;if([,C]=p.split(" ",2),C=Math.min(parseInt(C,10),5),f=await this.getCommitRefs(i,n,o,s,{path:u,last:C,before:p}),f==null)return[];const q=[];for(const{oid:Y}of f.values){if(Y===c)break;q.push(Y)}return q.reverse()}async getCommitDate(i,n,o,s){var u,c;const h=k.Y.getCorrelationContext();try{const f=`query getCommitDate(
	$owner: String!
	$repo: String!
	$sha: GitObjectID!
) {
	repository(name: $repo, owner: $owner) {
		object(oid: $sha) {
			... on Commit { committer { date } }
		}
	}
}`,p=await this.graphql(i,f,{owner:n,repo:o,sha:s});return(c=(u=p?.repository)==null?void 0:u.object)==null?void 0:c.committer.date}catch(f){return this.handleException(f,h,void 0)}}async getContributors(i,n,o){const s=k.Y.getCorrelationContext();try{const u=await this.request(i,"GET /repos/{owner}/{repo}/contributors",{owner:n,repo:o,per_page:100});return u?.data==null?[]:u.data}catch(u){return this.handleException(u,s,[])}}async getDefaultBranchName(i,n,o){var s,u;const c=k.Y.getCorrelationContext();try{const h=`query getDefaultBranch(
	$owner: String!
	$repo: String!
) {
	repository(owner: $owner, name: $repo) {
		defaultBranchRef {
			name
		}
	}
}`,f=await this.graphql(i,h,{owner:n,repo:o});return f==null?void 0:((u=(s=f.repository)==null?void 0:s.defaultBranchRef)==null?void 0:u.name)??void 0}catch(h){return this.handleException(h,c,void 0)}}async getCurrentUser(i,n,o){var s,u,c,h;const f=k.Y.getCorrelationContext();try{const p=`query getCurrentUser(
	$owner: String!
	$repo: String!
) {
	viewer { name, email, login, id }
	repository(owner: $owner, name: $repo) { viewerPermission }
}`,C=await this.graphql(i,p,{owner:n,repo:o});return C==null?void 0:{name:(s=C.viewer)==null?void 0:s.name,email:(u=C.viewer)==null?void 0:u.email,username:(c=C.viewer)==null?void 0:c.login,id:(h=C.viewer)==null?void 0:h.id}}catch(p){return this.handleException(p,f,void 0)}}async getRepositoryVisibility(i,n,o){var s;const u=k.Y.getCorrelationContext();try{const c=`query getRepositoryVisibility(
	$owner: String!
	$repo: String!
) {
	repository(owner: $owner, name: $repo) {
		visibility
	}
}`,h=await this.graphql(i,c,{owner:n,repo:o});return((s=h?.repository)==null?void 0:s.visibility)==null?void 0:h.repository.visibility==="PUBLIC"?H.q.Public:H.q.Private}catch(c){return this.handleException(c,u,void 0)}}async getTags(i,n,o,s){var u;const c=k.Y.getCorrelationContext();try{const h=`query getTags(
	$owner: String!
	$repo: String!
	$tagQuery: String
	$cursor: String
	$limit: Int = 100
) {
	repository(owner: $owner, name: $repo) {
		refs(query: $tagQuery, refPrefix: "refs/tags/", first: $limit, after: $cursor, orderBy: { field: TAG_COMMIT_DATE, direction: DESC }) {
			pageInfo {
				endCursor
				hasNextPage
			}
			nodes {
				name
				target {
					oid
					commitUrl
					...on Commit {
						authoredDate
						committedDate
						message
					}
					...on Tag {
						message
						tagger { date }
					}
				}
			}
		}
	}
}`,f=await this.graphql(i,h,{owner:n,repo:o,tagQuery:s?.query,cursor:s?.cursor,limit:Math.min(100,s?.limit??100)});if(f==null)return Ce;const p=(u=f.repository)==null?void 0:u.refs;return p==null?Ce:{paging:{cursor:p.pageInfo.endCursor,more:p.pageInfo.hasNextPage},values:p.nodes}}catch(h){return this.handleException(h,c,Ce)}}async resolveReference(i,n,o,s,u){var c,h,f,p,C,q;const Y=k.Y.getCorrelationContext();try{if(!u){const te=`query resolveReference(
	$owner: String!
	$repo: String!
	$ref: String!
) {
	repository(owner: $owner, name: $repo) {
		object(expression: $ref) {
			oid
		}
	}
}`,se=await this.graphql(i,te,{owner:n,repo:o,ref:s});return((h=(c=se?.repository)==null?void 0:c.object)==null?void 0:h.oid)??void 0}const K=`query resolveReference(
	$owner: String!
	$repo: String!
	$ref: String!
	$path: String!
) {
	repository(owner: $owner, name: $repo) {
		object(expression: $ref) {
			... on Commit {
				history(first: 1, path: $path) {
					nodes { oid }
				}
			}
		}
	}
}`,I=await this.graphql(i,K,{owner:n,repo:o,ref:s,path:u});return((q=(C=(p=(f=I?.repository)==null?void 0:f.object)==null?void 0:p.history.nodes)==null?void 0:C[0])==null?void 0:q.oid)??void 0}catch(K){return this.handleException(K,Y,void 0)}}async searchCommits(i,n,o){const s=k.Y.getCorrelationContext(),u=Math.min(100,o?.limit??100);let c,h,f;o?.cursor!=null?([c,h,f]=o.cursor.split(" ",3),c=parseInt(c,10),h=parseInt(h,10),f=parseInt(f,10)):(c=1,h=u,f=0);try{const p=await this.request(i,"GET /search/commits",{q:n,sort:o?.sort,order:o?.order,per_page:h,page:c}),C=p?.data;if(C==null||C.items.length===0)return;const q=C.items.map(I=>{var te,se,we,$e,je,tt,rt,it,nt,ot,st,at,lt;return{oid:I.sha,parents:{nodes:I.parents.map(ht=>({oid:ht.sha}))},message:I.commit.message,author:{avatarUrl:((te=I.author)==null?void 0:te.avatar_url)??void 0,date:((se=I.commit.author)==null?void 0:se.date)??((we=I.commit.author)==null?void 0:we.date)??new Date().toString(),email:(($e=I.author)==null?void 0:$e.email)??((je=I.commit.author)==null?void 0:je.email)??void 0,name:((tt=I.author)==null?void 0:tt.name)??((rt=I.commit.author)==null?void 0:rt.name)??""},committer:{date:((it=I.commit.committer)==null?void 0:it.date)??((nt=I.committer)==null?void 0:nt.date)??new Date().toString(),email:((ot=I.committer)==null?void 0:ot.email)??((st=I.commit.committer)==null?void 0:st.email)??void 0,name:((at=I.committer)==null?void 0:at.name)??((lt=I.commit.committer)==null?void 0:lt.name)??""}}}),Y=f+C.items.length,K=C.incomplete_results||C.total_count>Y;return{pageInfo:{startCursor:`${c} ${h} ${f}`,endCursor:K?`${c+1} ${h} ${Y}`:void 0,hasPreviousPage:C.total_count>0&&c>1,hasNextPage:K},totalCount:C.total_count,values:q}}catch(p){return this.handleException(p,s,void 0)}}octokit(i,n){let o=this._octokits.get(i);if(o==null){let s;if(P.$L){let u=y(function(c,h){if(h.headers!=null){const f=h.headers,{"user-agent":p}=f,C=dt(f,["user-agent"]);p&&(h.headers=C)}return(0,B.h)(c,h)},"fetchCore");s=U.defaults({auth:`token ${i}`,request:{fetch:u}})}else s=U.defaults({auth:`token ${i}`,request:{agent:this.proxyAgent}});o=new s(n),this._octokits.set(i,o),(k.Y.logLevel===k.i.Debug||k.Y.isDebugging)&&o.hook.wrap("request",async(u,c)=>{const h=new be.u(`[GITHUB] ${c.method} ${c.url}`,{log:!1});try{return await u(c)}finally{let f;try{if(typeof c.query=="string"){const p=/(^[^({\n]+)/.exec(c.query);f=` ${p?.[1].trim()??c.query}`}}catch{}h.stop({message:f})}})}return o}async graphql(i,n,o){var s,u,c,h,f;try{return await this.octokit(i).graphql(n,o)}catch(p){if(p instanceof e){switch((u=(s=p.errors)==null?void 0:s[0])==null?void 0:u.type){case"NOT_FOUND":throw new Z.Ww(p);case"FORBIDDEN":throw new Z._7("github",Z.Jx.Forbidden,p);case"RATE_LIMITED":{let C;const q=(c=p.headers)==null?void 0:c["x-ratelimit-reset"];throw q!=null&&(C=parseInt(q,10),Number.isNaN(C)&&(C=void 0)),new Z.yx(p,i,C)}}k.Y.isDebugging&&O.window.showErrorMessage(`GitHub request failed: ${((f=(h=p.errors)==null?void 0:h[0])==null?void 0:f.message)??p.message}`)}else p instanceof ee?this.handleRequestError(p,i):k.Y.isDebugging&&O.window.showErrorMessage(`GitHub request failed: ${p.message}`);throw p}}async request(i,n,o){try{return await this.octokit(i).request(n,o)}catch(s){throw s instanceof ee?this.handleRequestError(s,i):k.Y.isDebugging&&O.window.showErrorMessage(`GitHub request failed: ${s.message}`),s}}handleRequestError(i,n){var o,s,u,c,h;switch(i.status){case 404:case 410:case 422:throw new Z.Ww(i);case 401:throw new Z._7("github",Z.Jx.Unauthorized,i);case 403:if(i.message.includes("rate limit exceeded")){let f;const p=(s=(o=i.response)==null?void 0:o.headers)==null?void 0:s["x-ratelimit-reset"];throw p!=null&&(f=parseInt(p,10),Number.isNaN(f)&&(f=void 0)),new Z.yx(i,n,f)}throw new Z._7("github",Z.Jx.Forbidden,i);case 500:i.response!=null&&O.window.showErrorMessage("GitHub failed to respond and might be experiencing issues. Please visit the [GitHub status page](https://githubstatus.com) for more information.","OK");return;case 502:if(i.message.includes("timeout")){O.window.showErrorMessage("GitHub request timed out");return}break;default:if(i.status>=400&&i.status<500)throw new Z.Bn(i);break}k.Y.isDebugging&&O.window.showErrorMessage(`GitHub request failed: ${((h=(c=(u=i.response)==null?void 0:u.errors)==null?void 0:c[0])==null?void 0:h.message)??i.message}`)}handleException(i,n,o){if(i instanceof Z.Ww)return o;throw k.Y.error(i,n),i instanceof Z._7&&this.showAuthenticationErrorMessage(i),i}async showAuthenticationErrorMessage(i){if(i.reason===Z.Jx.Unauthorized||i.reason===Z.Jx.Forbidden){const n="Reauthenticate";await O.window.showErrorMessage(`${i.message}. Would you like to try reauthenticating${i.reason===Z.Jx.Forbidden?" to provide additional access":""}?`,n)===n&&this._onDidReauthenticate.fire()}else O.window.showErrorMessage(i.message)}}y(re,"GitHubApi"),oe([(0,Q.fF)({args:{0:l=>l.name,1:"<token>"}})],re.prototype,"getAccountForCommit",1),oe([(0,Q.fF)({args:{0:l=>l.name,1:"<token>"}})],re.prototype,"getAccountForEmail",1),oe([(0,Q.fF)({args:{0:l=>l.name,1:"<token>"}})],re.prototype,"getDefaultBranch",1),oe([(0,Q.fF)({args:{0:l=>l.name,1:"<token>"}})],re.prototype,"getIssueOrPullRequest",1),oe([(0,Q.fF)({args:{0:l=>l.name,1:"<token>"}})],re.prototype,"getPullRequestForBranch",1),oe([(0,Q.fF)({args:{0:l=>l.name,1:"<token>"}})],re.prototype,"getPullRequestForCommit",1),oe([(0,Q.fF)({args:{0:"<token>"}})],re.prototype,"getBlame",1),oe([(0,Q.fF)({args:{0:"<token>"}})],re.prototype,"getBranches",1),oe([(0,Q.fF)({args:{0:"<token>"}})],re.prototype,"getCommit",1),oe([(0,Q.fF)({args:{0:"<token>"}})],re.prototype,"getCommitForFile",1),oe([(0,Q.fF)({args:{0:"<token>"}})],re.prototype,"getCommitBranches",1),oe([(0,Q.fF)({args:{0:"<token>"}})],re.prototype,"getCommitCount",1),oe([(0,Q.fF)({args:{0:"<token>"}})],re.prototype,"getCommitOnBranch",1),oe([(0,Q.fF)({args:{0:"<token>"}})],re.prototype,"getCommits",1),oe([(0,Q.fF)({args:{0:"<token>"}})],re.prototype,"getCommitRefs",1),oe([(0,Q.fF)({args:{0:"<token>"}})],re.prototype,"getNextCommitRefs",1),oe([(0,Q.fF)({args:{0:"<token>"}})],re.prototype,"getContributors",1),oe([(0,Q.fF)({args:{0:"<token>"}})],re.prototype,"getDefaultBranchName",1),oe([(0,Q.fF)({args:{0:"<token>"}})],re.prototype,"getCurrentUser",1),oe([(0,Q.fF)({args:{0:"<token>"}})],re.prototype,"getRepositoryVisibility",1),oe([(0,Q.fF)({args:{0:"<token>"}})],re.prototype,"getTags",1),oe([(0,Q.fF)({args:{0:"<token>"}})],re.prototype,"resolveReference",1),oe([(0,Q.fF)({args:{0:"<token>"}})],re.prototype,"searchCommits",1);var Oe;(l=>{function i(s,u){return new X.PullRequest(u,{name:s.author.login,avatarUrl:s.author.avatarUrl,url:s.author.url},String(s.number),s.title,s.permalink,n(s.state),new Date(s.updatedAt),s.closedAt==null?void 0:new Date(s.closedAt),s.mergedAt==null?void 0:new Date(s.mergedAt))}y(i,"from"),l.from=i;function n(s){return s==="MERGED"?X.PullRequestState.Merged:s==="CLOSED"?X.PullRequestState.Closed:X.PullRequestState.Open}y(n,"fromState"),l.fromState=n;function o(s){return s===X.PullRequestState.Merged?"MERGED":s===X.PullRequestState.Closed?"CLOSED":"OPEN"}y(o,"toState"),l.toState=o})(Oe||(Oe={}));function gt(l){switch(l){case"added":return X.GitFileIndexStatus.Added;case"changed":case"modified":return X.GitFileIndexStatus.Modified;case"removed":return X.GitFileIndexStatus.Deleted;case"renamed":return X.GitFileIndexStatus.Renamed;case"copied":return X.GitFileIndexStatus.Copied}}y(gt,"fromCommitFileStatus")},3333:(ae,le,_)=>{"use strict";_.r(le),_.d(le,{GitHubGitProvider:()=>w});var T=_(9496),ie=_(7267),W=_(9179),V=_(1045),z=_(313),L=_(5396),de=_(6532),ge=_(5059),Me=_(6643),ue=_(2324),b=_(2833),he=_(7358),pe=_(3969),A=_(2436),me=_(2062),fe=_(5861),$=_(7369),Se=_(2886),ve=_(516),ke=_(680),Te=_(2378);async function Ge(G){try{const e=T.extensions.getExtension("GitHub.remotehub");if(e==null)throw A.Y.log("GitHub Repositories extension is not installed or enabled"),new L.R5("GitHub Repositories","GitHub.remotehub");return e.isActive?e.exports:await e.activate()}catch(e){if(A.Y.error(e,"Unable to get required api from the GitHub Repositories extension"),e instanceof L.R5,G)return;throw e}}y(Ge,"getRemoteHubApi");var He=(G=>(G[G.Branch=0]="Branch",G[G.RemoteBranch=1]="RemoteBranch",G[G.Tag=2]="Tag",G[G.Commit=3]="Commit",G))(He||{}),Ue=(G=>(G[G.Branch=0]="Branch",G[G.Tag=1]="Tag",G[G.Commit=2]="Commit",G[G.PullRequest=3]="PullRequest",G[G.Tree=4]="Tree",G))(Ue||{}),Ee=_(8026),Ie=Object.defineProperty,Qe=Object.defineProperties,Ve=Object.getOwnPropertyDescriptor,ze=Object.getOwnPropertyDescriptors,Pe=Object.getOwnPropertySymbols,We=Object.prototype.hasOwnProperty,Be=Object.prototype.propertyIsEnumerable,Ae=y((G,e,t)=>e in G?Ie(G,e,{enumerable:!0,configurable:!0,writable:!0,value:t}):G[e]=t,"__defNormalProp"),ne=y((G,e)=>{for(var t in e||(e={}))We.call(e,t)&&Ae(G,t,e[t]);if(Pe)for(var t of Pe(e))Be.call(e,t)&&Ae(G,t,e[t]);return G},"__spreadValues"),ee=y((G,e)=>Qe(G,ze(e)),"__spreadProps"),R=y((G,e,t,r)=>{for(var a=r>1?void 0:r?Ve(e,t):e,g=G.length-1,d;g>=0;g--)(d=G[g])&&(a=(r?d(e,t,a):d(a))||a);return r&&a&&Ie(e,t,a),a},"__decorateClass"),ce=y((G,e,t)=>(Ae(G,typeof e!="symbol"?e+"":e,t),t),"__publicField");const Fe=Object.freeze({values:[]}),Re=Promise.resolve(void 0),Ye=["repo","read:user","user:email"],qe=/^[^/](?!.*\/\.)(?!.*\.\.)(?!.*\/\/)(?!.*@\{)[^\000-\037\177 ~^:?*[\\]+[^./]$/;class w{constructor(e){this.container=e,ce(this,"descriptor",{id:ge.p.GitHub,name:"GitHub"}),ce(this,"supportedSchemes",new Set([V.sN.Virtual,V.sN.GitHub,V.sN.PRs])),ce(this,"_onDidChangeRepository",new T.EventEmitter),ce(this,"_onDidCloseRepository",new T.EventEmitter),ce(this,"_onDidOpenRepository",new T.EventEmitter),ce(this,"_branchesCache",new Map),ce(this,"_repoInfoCache",new Map),ce(this,"_tagsCache",new Map),ce(this,"_disposables",[]),ce(this,"_allowedFeatures",new Map),ce(this,"_github"),ce(this,"_remotehub"),ce(this,"_remotehubPromise"),ce(this,"_sessionPromise")}get onDidChangeRepository(){return this._onDidChangeRepository.event}get onDidCloseRepository(){return this._onDidCloseRepository.event}get onDidOpenRepository(){return this._onDidOpenRepository.event}dispose(){this._disposables.forEach(e=>e.dispose())}onRepositoryChanged(e,t){this._branchesCache.delete(e.path),this._tagsCache.delete(e.path),this._repoInfoCache.delete(e.path),this._onDidChangeRepository.fire(t)}async discoverRepositories(e){if(!this.supportedSchemes.has(e.scheme))return[];try{const{remotehub:t}=await this.ensureRepositoryContext(e.toString(),!0),r=t.getVirtualWorkspaceUri(e);return r==null?[]:[this.openRepository(void 0,r,!0)]}catch{return[]}}updateContext(){(0,z.v)(V.zf.HasVirtualFolders,this.container.git.hasOpenRepositories(this.descriptor.id))}openRepository(e,t,r,a,g){return new b.Repository(this.container,this.onRepositoryChanged.bind(this),this.descriptor,e,t,r,a??!T.window.state.focused,g)}async allows(e,t,r){var a;if(t===me.Cx.Free)return!1;if(t===me.Cx.Pro)return!0;if(r==null){const v=[...this.container.git.getOpenRepositories(this.descriptor.id)];for await(const m of(0,ke.Wx)(v.map(S=>this.allows(e,t,S.path))))if(m.status!=="fulfilled"||!m.value)return!1;return!0}let g=this._allowedFeatures.get(r),d=g?.get(e);return d!=null||(d=(a=Me.o.previewFeatures)!=null&&a.get(e)?!0:await this.visibility(r)===ge.q.Public,g==null&&(g=new Map,this._allowedFeatures.set(r,g)),g.set(e,d)),d}async supports(e){switch(e){case de.A.Worktrees:return!1;default:return!0}}async visibility(e){const t=await this.getRemotes(e);if(t.length===0)return ge.q.Local;const r=t.find(a=>a.name==="origin");return r!=null?this.getRemoteVisibility(r):ge.q.Private}async getRemoteVisibility(e){var t;switch((t=e.provider)==null?void 0:t.id){case"github":{const{github:r,metadata:a,session:g}=await this.ensureRepositoryContext(e.repoPath);return await r.getRepositoryVisibility(g.accessToken,a.repo.owner,a.repo.name)??ge.q.Private}default:return ge.q.Private}}async getOpenScmRepositories(){return[]}async getOrOpenScmRepository(e){}canHandlePathOrUri(e,t){if(!!this.supportedSchemes.has(e))return typeof t=="string"?t:t.toString()}getAbsoluteUri(e,t){if(typeof t=="string")if((0,ve.tE)(t))t=T.Uri.parse(t,!0);else throw T.window.showErrorMessage(`Unable to get absolute uri between ${typeof e=="string"?e:e.toString(!1)} and ${t}; Base path '${t}' must be a uri`),new Error(`Base path '${t}' must be a uri`);if(typeof e=="string"&&!(0,ve.tE)(e)&&!(0,ve.YP)(e))return T.Uri.joinPath(t,(0,ve.AH)(e));const r=this.getRelativePath(e,t);return T.Uri.joinPath(t,r)}async getBestRevisionUri(e,t,r){return r?this.createProviderUri(e,r,t):this.createVirtualUri(e,r,t)}getRelativePath(e,t){if(typeof t=="string")if((0,ve.tE)(t))t=T.Uri.parse(t,!0);else throw T.window.showErrorMessage(`Unable to get relative path between ${typeof e=="string"?e:e.toString(!1)} and ${t}; Base path '${t}' must be a uri`),new Error(`Base path '${t}' must be a uri`);let r;if(typeof e=="string")if((0,ve.tE)(e))e=T.Uri.parse(e,!0);else return e=(0,ve.AH)(e),r=(0,ve.YP)(e)&&e.startsWith(t.path)?e.slice(t.path.length):e,r.charCodeAt(0)===V.mN.Slash&&(r=r.slice(1)),r;return r=(0,ve.AH)((0,ve.Gf)(t.path.slice(1),e.path.slice(1))),r}getRevisionUri(e,t,r){const a=this.createProviderUri(e,r,t);return r===b.GitRevision.deletedOrMissing?a.with({query:"~"}):a}async getWorkingUri(e,t){return this.createVirtualUri(e,void 0,t.path)}async addRemote(e,t,r){}async pruneRemote(e,t){}async applyChangesToWorkingFile(e,t,r){}async branchContainsCommit(e,t,r){return!1}async checkout(e,t,r){}resetCaches(...e){(e.length===0||e.includes("branches"))&&this._branchesCache.clear(),(e.length===0||e.includes("tags"))&&this._tagsCache.clear(),e.length===0&&this._repoInfoCache.clear()}async excludeIgnoredUris(e,t){return t}async fetch(e,t){}async findRepositoryUri(e,t){const r=A.Y.getCorrelationContext();try{return(await this.ensureRemoteHubApi()).getProviderRootUri(e).with({scheme:V.sN.Virtual})}catch(a){a instanceof L.R5,A.Y.error(a,r);return}}async getAheadBehindCommitCount(e,t){}async getBlame(e,t){const r=A.Y.getCorrelationContext();if(t?.isDirty)return;let a="blame";e.sha!=null&&(a+=`:${e.sha}`);const g=await this.container.tracker.getOrAdd(e);if(g.state!=null){const v=g.state.getBlame(a);if(v!=null)return A.Y.debug(r,`Cache hit: '${a}'`),v.item}A.Y.debug(r,`Cache miss: '${a}'`),g.state==null&&(g.state=new Te.p2(g.key));const d=this.getBlameCore(e,g,a,r);if(g.state!=null){A.Y.debug(r,`Cache add: '${a}'`);const v={item:d};g.state.setBlame(a,v)}return d}async getBlameCore(e,t,r,a){var g,d;try{const v=await this.ensureRepositoryContext(e.repoPath);if(v==null)return;const{metadata:m,github:S,remotehub:M,session:E}=v,F=M.getVirtualUri(M.getProviderRootUri(e)),D=this.getRelativePath(e,F);if(e.scheme===V.sN.Virtual){const[P,j]=await Promise.allSettled([T.workspace.fs.stat(e),T.workspace.fs.stat(e.with({scheme:V.sN.GitHub}))]);if(P.status!=="fulfilled"||j.status!=="fulfilled"||P.value.mtime!==j.value.mtime)return}const N=!e.sha||e.sha==="HEAD"?(await m.getRevision()).revision:e.sha,J=await S.getBlame(E.accessToken,m.repo.owner,m.repo.name,N,D),x=new Map,U=new Map,O=[];for(const P of J.ranges){const j=P.commit,{viewer:Z=E.account.label}=J,H=Z!=null&&j.author.name===Z?"You":j.author.name,X=Z!=null&&j.committer.name===Z?"You":j.committer.name;let k=x.get(H);k==null&&(k={name:H,lineCount:0},x.set(H,k)),k.lineCount+=P.endingLine-P.startingLine+1;let Q=U.get(j.oid);Q==null&&(Q=new b.GitCommit(this.container,e.repoPath,j.oid,new b.GitCommitIdentity(H,j.author.email,new Date(j.author.date),j.author.avatarUrl),new b.GitCommitIdentity(X,j.committer.email,new Date(j.author.date)),j.message.split(`
`,1)[0],(g=j.parents.nodes[0])!=null&&g.oid?[(d=j.parents.nodes[0])==null?void 0:d.oid]:[],j.message,new b.GitFileChange(F.toString(),D,b.GitFileIndexStatus.Modified),{changedFiles:j.changedFiles??0,additions:j.additions??0,deletions:j.deletions??0},[]),U.set(j.oid,Q));for(let be=P.startingLine;be<=P.endingLine;be++){const xe={sha:j.oid,originalLine:be,line:be};Q.lines.push(xe),O[be-1]=xe}}const B=new Map([...x.entries()].sort((P,j)=>j[1].lineCount-P[1].lineCount));return{repoPath:e.repoPath,authors:B,commits:U,lines:O}}catch(v){if(t.state!=null&&!/No provider registered with/.test(String(v))){const m=v?.toString()??"";A.Y.debug(a,`Cache replace (with empty promise): '${r}'`);const S={item:Re,errorMessage:m};return t.state.setBlame(r,S),t.setBlameFailure(),Re}return}}async getBlameContents(e,t){}async getBlameForLine(e,t,r,a){var g,d;const v=A.Y.getCorrelationContext();if(!r?.isDirty){if(!a?.forceSingleLine){const m=await this.getBlame(e);if(m==null)return;let S=m.lines[t];if(S==null){if(m.lines.length!==t)return;S=m.lines[t-1]}const M=m.commits.get(S.sha);if(M==null)return;const E=m.authors.get(M.author.name);return{author:ee(ne({},E),{lineCount:M.lines.length}),commit:M,line:S}}try{const m=await this.ensureRepositoryContext(e.repoPath);if(m==null)return;const{metadata:S,github:M,remotehub:E,session:F}=m,D=E.getVirtualUri(E.getProviderRootUri(e)),N=this.getRelativePath(e,D),J=!e.sha||e.sha==="HEAD"?(await S.getRevision()).revision:e.sha,x=await M.getBlame(F.accessToken,S.repo.owner,S.repo.name,J,N),U=t+1,O=x.ranges.find(X=>X.startingLine===U);if(O==null)return;const B=O.commit,{viewer:P=F.account.label}=x,j=P!=null&&B.author.name===P?"You":B.author.name,Z=P!=null&&B.committer.name===P?"You":B.committer.name,H=new b.GitCommit(this.container,e.repoPath,B.oid,new b.GitCommitIdentity(j,B.author.email,new Date(B.author.date),B.author.avatarUrl),new b.GitCommitIdentity(Z,B.committer.email,new Date(B.author.date)),B.message.split(`
`,1)[0],(g=B.parents.nodes[0])!=null&&g.oid?[(d=B.parents.nodes[0])==null?void 0:d.oid]:[],B.message,new b.GitFileChange(D.toString(),N,b.GitFileIndexStatus.Modified),{changedFiles:B.changedFiles??0,additions:B.additions??0,deletions:B.deletions??0},[]);for(let X=O.startingLine;X<=O.endingLine;X++){const k={sha:B.oid,originalLine:X,line:X};H.lines.push(k)}return{author:{name:j,lineCount:O.endingLine-O.startingLine+1},commit:H,line:{sha:B.oid,originalLine:O.startingLine,line:O.startingLine}}}catch(m){A.Y.error(v,m);return}}}async getBlameForLineContents(e,t,r,a){}async getBlameForRange(e,t){const r=await this.getBlame(e);if(r!=null)return this.getBlameRange(r,e,t)}async getBlameForRangeContents(e,t,r){const a=await this.getBlameContents(e,r);if(a!=null)return this.getBlameRange(a,e,t)}getBlameRange(e,t,r){if(e.lines.length===0)return ne({allLines:e.lines},e);if(r.start.line===0&&r.end.line===e.lines.length-1)return ne({allLines:e.lines},e);const a=e.lines.slice(r.start.line,r.end.line+1),g=new Set(a.map(E=>E.sha)),d=r.start.line+1,v=r.end.line+1,m=new Map,S=new Map;for(const E of e.commits.values()){if(!g.has(E.sha))continue;const F=E.with({lines:E.lines.filter(N=>N.line>=d&&N.line<=v)});S.set(E.sha,F);let D=m.get(F.author.name);D==null&&(D={name:F.author.name,lineCount:0},m.set(D.name,D)),D.lineCount+=F.lines.length}const M=new Map([...m.entries()].sort((E,F)=>F[1].lineCount-E[1].lineCount));return{repoPath:t.repoPath,authors:M,commits:S,lines:a,allLines:e.lines}}async getBranch(e){const{values:[t]}=await this.getBranches(e,{filter:r=>r.current});return t}async getBranches(e,t){if(e==null)return Fe;const r=A.Y.getCorrelationContext();let a=t?.cursor?void 0:this._branchesCache.get(e);if(a==null){async function d(){var v;try{const{metadata:m,github:S,session:M}=await this.ensureRepositoryContext(e),E=await m.getRevision(),F=E.type===0?E.name:void 0,D=[];let N=t?.cursor;const J=N==null;for(;;){const x=await S.getBranches(M.accessToken,m.repo.owner,m.repo.name,{cursor:N});for(const U of x.values){const O=new Date(this.container.config.advanced.commitOrdering==="author-date"?U.target.authoredDate:U.target.committedDate),B=U.target.oid;D.push(new b.GitBranch(e,U.name,!1,U.name===F,O,B,{name:`origin/${U.name}`,missing:!1}),new b.GitBranch(e,`origin/${U.name}`,!0,!1,O,B))}if(!((v=x.paging)!=null&&v.more)||!J)return ee(ne({},x),{values:D});N=x.paging.cursor}}catch(m){return A.Y.error(m,r),this._branchesCache.delete(e),Fe}}y(d,"load"),a=d.call(this),t?.cursor==null&&this._branchesCache.set(e,a)}let g=await a;return t?.filter!=null&&(g=ee(ne({},g),{values:g.values.filter(t.filter)})),t?.sort!=null&&b.GitBranch.sort(g.values,typeof t.sort=="boolean"?void 0:t.sort),g}async getChangedFilesCount(e,t){if(!t)return;const r=await this.getCommit(e,t);if(r?.stats==null)return;const{stats:a}=r,g=typeof a.changedFiles=="number"?a.changedFiles:a.changedFiles.added+a.changedFiles.changed+a.changedFiles.deleted;return{additions:a.additions,deletions:a.deletions,changedFiles:g}}async getCommit(e,t){var r;if(e==null)return;const a=A.Y.getCorrelationContext();try{const{metadata:g,github:d,session:v}=await this.ensureRepositoryContext(e),m=await d.getCommit(v.accessToken,g.repo.owner,g.repo.name,t);if(m==null)return;const{viewer:S=v.account.label}=m,M=S!=null&&m.author.name===S?"You":m.author.name,E=S!=null&&m.committer.name===S?"You":m.committer.name;return new b.GitCommit(this.container,e,m.oid,new b.GitCommitIdentity(M,m.author.email,new Date(m.author.date),m.author.avatarUrl),new b.GitCommitIdentity(E,m.committer.email,new Date(m.committer.date)),m.message.split(`
`,1)[0],m.parents.nodes.map(F=>F.oid),m.message,((r=m.files)==null?void 0:r.map(F=>new b.GitFileChange(e,F.filename??"",(0,Ee.fromCommitFileStatus)(F.status)??b.GitFileIndexStatus.Modified,F.previous_filename,void 0,{additions:F.additions??0,deletions:F.deletions??0,changes:F.changes??0})))??[],{changedFiles:m.changedFiles??0,additions:m.additions??0,deletions:m.deletions??0},[])}catch(g){A.Y.error(g,a);return}}async getCommitBranches(e,t,r){if(e==null||r?.commitDate==null)return[];const a=A.Y.getCorrelationContext();try{const{metadata:g,github:d,session:v}=await this.ensureRepositoryContext(e);let m;return r?.branch?m=await d.getCommitOnBranch(v.accessToken,g.repo.owner,g.repo.name,r?.branch,t,r?.commitDate):m=await d.getCommitBranches(v.accessToken,g.repo.owner,g.repo.name,t,r?.commitDate),m}catch(g){return A.Y.error(g,a),[]}}async getCommitCount(e,t){if(e==null)return;const r=A.Y.getCorrelationContext();try{const{metadata:a,github:g,session:d}=await this.ensureRepositoryContext(e);return await g.getCommitCount(d?.accessToken,a.repo.owner,a.repo.name,t)}catch(a){A.Y.error(a,r);return}}async getCommitForFile(e,t,r){var a;if(e==null)return;const g=A.Y.getCorrelationContext();try{const{metadata:d,github:v,remotehub:m,session:S}=await this.ensureRepositoryContext(e),M=this.getRelativePath(t,m.getProviderRootUri(t)),E=!r?.ref||r.ref==="HEAD"?(await d.getRevision()).revision:r.ref,F=await v.getCommitForFile(S.accessToken,d.repo.owner,d.repo.name,E,M);if(F==null)return;const{viewer:D=S.account.label}=F,N=D!=null&&F.author.name===D?"You":F.author.name,J=D!=null&&F.committer.name===D?"You":F.committer.name,x=(a=F.files)==null?void 0:a.map(O=>new b.GitFileChange(e,O.filename??"",(0,Ee.fromCommitFileStatus)(O.status)??b.GitFileIndexStatus.Modified,O.previous_filename,void 0,{additions:O.additions??0,deletions:O.deletions??0,changes:O.changes??0})),U=x?.find(O=>O.path===M);return new b.GitCommit(this.container,e,F.oid,new b.GitCommitIdentity(N,F.author.email,new Date(F.author.date),F.author.avatarUrl),new b.GitCommitIdentity(J,F.committer.email,new Date(F.committer.date)),F.message.split(`
`,1)[0],F.parents.nodes.map(O=>O.oid),F.message,{file:U,files:x},{changedFiles:F.changedFiles??0,additions:F.additions??0,deletions:F.deletions??0},[])}catch(d){A.Y.error(d,g);return}}async getOldestUnpushedRefForFile(e,t){}async getContributors(e,t){if(e==null)return[];const r=A.Y.getCorrelationContext();try{const{metadata:a,github:g,session:d}=await this.ensureRepositoryContext(e),v=await g.getContributors(d.accessToken,a.repo.owner,a.repo.name),m=await this.getCurrentUser(e),S=[];for(const M of v)M.type==="User"&&S.push(new b.GitContributor(e,M.name,M.email,M.contributions,void 0,(0,b.isUserMatch)(m,M.name,M.email,M.login),void 0,M.login,M.avatar_url,M.node_id));return S}catch(a){return A.Y.error(a,r),[]}}async getCurrentUser(e){if(!e)return;const t=A.Y.getCorrelationContext(),r=this._repoInfoCache.get(e);let a=r?.user;if(a!=null)return a;if(a!==null)try{const{metadata:g,github:d,session:v}=await this.ensureRepositoryContext(e);return a=await d.getCurrentUser(v.accessToken,g.repo.owner,g.repo.name),this._repoInfoCache.set(e,ee(ne({},r),{user:a??null})),a}catch(g){A.Y.error(g,t),this._repoInfoCache.set(e,ee(ne({},r),{user:null}));return}}async getDefaultBranchName(e,t){if(e==null)return;const r=A.Y.getCorrelationContext();try{const{metadata:a,github:g,session:d}=await this.ensureRepositoryContext(e);return await g.getDefaultBranchName(d.accessToken,a.repo.owner,a.repo.name)}catch(a){A.Y.error(a,r);return}}async getDiffForFile(e,t,r){}async getDiffForFileContents(e,t,r){}async getDiffForLine(e,t,r,a){}async getDiffStatus(e,t,r,a){}async getFileStatusForCommit(e,t,r){if(r===b.GitRevision.deletedOrMissing||b.GitRevision.isUncommitted(r))return;const a=await this.getCommitForFile(e,t,{ref:r});if(a!=null)return a.findFile(t)}async getLastFetchedTimestamp(e){}async getLog(e,t){var r,a,g;if(e==null)return;const d=A.Y.getCorrelationContext(),v=this.getPagingLimit(t?.limit);try{const{metadata:m,github:S,session:M}=await this.ensureRepositoryContext(e),E=!t?.ref||t.ref==="HEAD"?(await m.getRevision()).revision:t.ref,F=await S.getCommits(M.accessToken,m.repo.owner,m.repo.name,E,{all:t?.all,authors:t?.authors,after:t?.cursor,limit:v,since:t?.since?new Date(t.since):void 0}),D=new Map,{viewer:N=M.account.label}=F;for(const x of F.values){const U=N!=null&&x.author.name===N?"You":x.author.name,O=N!=null&&x.committer.name===N?"You":x.committer.name;let B=D.get(x.oid);B==null&&(B=new b.GitCommit(this.container,e,x.oid,new b.GitCommitIdentity(U,x.author.email,new Date(x.author.date),x.author.avatarUrl),new b.GitCommitIdentity(O,x.committer.email,new Date(x.committer.date)),x.message.split(`
`,1)[0],x.parents.nodes.map(P=>P.oid),x.message,(r=x.files)==null?void 0:r.map(P=>new b.GitFileChange(e,P.filename??"",(0,Ee.fromCommitFileStatus)(P.status)??b.GitFileIndexStatus.Modified,P.previous_filename,void 0,{additions:P.additions??0,deletions:P.deletions??0,changes:P.changes??0})),{changedFiles:x.changedFiles??0,additions:x.additions??0,deletions:x.deletions??0},[]),D.set(x.oid,B))}const J={repoPath:e,commits:D,sha:E,range:void 0,count:D.size,limit:v,hasMore:((a=F.paging)==null?void 0:a.more)??!1,cursor:(g=F.paging)==null?void 0:g.cursor,query:x=>this.getLog(e,ee(ne({},t),{limit:x}))};return J.hasMore&&(J.more=this.getLogMoreFn(J,t)),J}catch(m){A.Y.error(m,d);return}}async getLogRefsOnly(e,t){const r=await this.getLog(e,t);if(r!=null)return new Set([...r.commits.values()].map(a=>a.ref))}getLogMoreFn(e,t){return async r=>{const a=r!=null&&typeof r=="object"?r.until:void 0;let g=typeof r=="number"?r:void 0;if(a&&(0,Se.G)(e.commits.values(),S=>S.ref===a))return e;g=this.getPagingLimit(g);const d=await this.getLog(e.repoPath,ee(ne({},t),{limit:g,cursor:e.cursor}));if(d==null)return ee(ne({},e),{hasMore:!1});const v=new Map([...e.commits,...d.commits]),m={repoPath:e.repoPath,commits:v,sha:e.sha,range:void 0,count:v.size,limit:a==null?(e.limit??0)+g:void 0,hasMore:a==null?d.hasMore:!0,cursor:d.cursor,query:e.query};return m.more=this.getLogMoreFn(m,t),m}}async getLogForSearch(e,t,r){var a,g,d;if(e==null)return;const v=A.Y.getCorrelationContext(),m=pe.n.parseSearchOperations(t.pattern);let S,M=m.get("commit:");if(M!=null){const D=await this.getCommit(e,M[0]);return D==null?void 0:{repoPath:e,commits:new Map([[D.sha,D]]),sha:D.sha,range:void 0,count:1,limit:1,hasMore:!1}}const E=[];for([S,M]of m.entries())switch(S){case"message:":E.push(...M.map(D=>D.replace(/ /g,"+")));break;case"author:":E.push(...M.map(D=>(D=D.replace(/ /g,"+"),D.startsWith("@")?`author:${D.slice(1)}`:D.startsWith('"@')?`author:"${D.slice(2)}`:D.includes("@")?`author-email:${D}`:`author-name:${D}`)));break}if(E.length===0)return;const F=this.getPagingLimit(r?.limit);try{const{metadata:D,github:N,session:J}=await this.ensureRepositoryContext(e),x=await N.searchCommits(J.accessToken,`repo:${D.repo.owner}/${D.repo.name}+${E.join("+").trim()}`,{cursor:r?.cursor,limit:F,sort:r?.ordering==="date"?"committer-date":r?.ordering==="author-date"?"author-date":void 0});if(x==null)return;const U=new Map,O=J.account.label;for(const P of x.values){const j=O!=null&&P.author.name===O?"You":P.author.name,Z=O!=null&&P.committer.name===O?"You":P.committer.name;let H=U.get(P.oid);H==null&&(H=new b.GitCommit(this.container,e,P.oid,new b.GitCommitIdentity(j,P.author.email,new Date(P.author.date),P.author.avatarUrl),new b.GitCommitIdentity(Z,P.committer.email,new Date(P.committer.date)),P.message.split(`
`,1)[0],P.parents.nodes.map(X=>X.oid),P.message,(a=P.files)==null?void 0:a.map(X=>new b.GitFileChange(e,X.filename??"",(0,Ee.fromCommitFileStatus)(X.status)??b.GitFileIndexStatus.Modified,X.previous_filename,void 0,{additions:X.additions??0,deletions:X.deletions??0,changes:X.changes??0})),{changedFiles:P.changedFiles??0,additions:P.additions??0,deletions:P.deletions??0},[]),U.set(P.oid,H))}const B={repoPath:e,commits:U,sha:void 0,range:void 0,count:U.size,limit:F,hasMore:((g=x.pageInfo)==null?void 0:g.hasNextPage)??!1,cursor:((d=x.pageInfo)==null?void 0:d.endCursor)??void 0,query:P=>this.getLog(e,ee(ne({},r),{limit:P}))};return B.hasMore&&(B.more=this.getLogForSearchMoreFn(B,t,r)),B}catch(D){A.Y.error(D,v);return}}getLogForSearchMoreFn(e,t,r){return async a=>{a=this.getPagingLimit(a);const g=await this.getLogForSearch(e.repoPath,t,ee(ne({},r),{limit:a,cursor:e.cursor}));if(g==null)return ee(ne({},e),{hasMore:!1});const d=new Map([...e.commits,...g.commits]),v={repoPath:e.repoPath,commits:d,sha:e.sha,range:void 0,count:d.size,limit:(e.limit??0)+a,hasMore:g.hasMore,cursor:g.cursor,query:e.query};return v.more=this.getLogForSearchMoreFn(v,t,r),v}}async getLogForFile(e,t,r){if(e==null)return;const a=A.Y.getCorrelationContext(),g=this.getRelativePath(t,e);if(e!=null&&e===g)throw new Error(`File name cannot match the repository path; path=${g}`);r=ne({reverse:!1},r),r.renames=!1,r.all=!1;let d="log";r.ref!=null&&(d+=`:${r.ref}`),r.limit=this.getPagingLimit(r?.limit),r.limit&&(d+=`:n${r.limit}`),r.renames&&(d+=":follow"),r.reverse&&(d+=":reverse"),r.since&&(d+=`:since=${r.since}`),r.skip&&(d+=`:skip${r.skip}`),r.cursor&&(d+=`:cursor=${r.cursor}`);const v=await this.container.tracker.getOrAdd(ue.YY.fromFile(g,e,r.ref));if(!r.force&&r.range==null){if(v.state!=null){const S=v.state.getLog(d);if(S!=null)return A.Y.debug(a,`Cache hit: '${d}'`),S.item;if(r.ref!=null||r.limit!=null){const M=v.state.getLog(`log${r.renames?":follow":""}${r.reverse?":reverse":""}`);if(M!=null){if(r.ref==null)return A.Y.debug(a,`Cache hit: ~'${d}'`),M.item;A.Y.debug(a,`Cache ?: '${d}'`);let E=await M.item;if(E!=null&&!E.hasMore&&E.commits.has(r.ref)){A.Y.debug(a,`Cache hit: '${d}'`);let F=!0,D=0;const N=new Map((0,Se.DZ)(E.commits.entries(),([x,U])=>{if(F){if(x!==r?.ref)return;F=!1}if(D++,!(r?.limit!=null&&D>r.limit))return[x,U]})),J=ne({},r);return E=ee(ne({},E),{limit:r.limit,count:N.size,commits:N,query:x=>this.getLogForFile(e,t,ee(ne({},J),{limit:x}))}),E}}}}A.Y.debug(a,`Cache miss: '${d}'`),v.state==null&&(v.state=new Te.p2(v.key))}const m=this.getLogForFileCore(e,g,v,d,a,r);if(v.state!=null&&r.range==null){A.Y.debug(a,`Cache add: '${d}'`);const S={item:m};v.state.setLog(d,S)}return m}async getLogForFileCore(e,t,r,a,g,d){var v,m,S;if(e==null)return;const M=this.getPagingLimit(d?.limit);try{const E=await this.ensureRepositoryContext(e);if(E==null)return;const{metadata:F,github:D,remotehub:N,session:J}=E,x=this.getAbsoluteUri(t,e),U=this.getRelativePath(x,N.getProviderRootUri(x)),O=!d?.ref||d.ref==="HEAD"?(await F.getRevision()).revision:d.ref,B=await D.getCommits(J.accessToken,F.repo.owner,F.repo.name,O,{all:d?.all,after:d?.cursor,path:U,limit:M,since:d?.since?new Date(d.since):void 0}),P=new Map,{viewer:j=J.account.label}=B;for(const H of B.values){const X=j!=null&&H.author.name===j?"You":H.author.name,k=j!=null&&H.committer.name===j?"You":H.committer.name;let Q=P.get(H.oid);if(Q==null){const be=(v=H.files)==null?void 0:v.map(ye=>new b.GitFileChange(e,ye.filename??"",(0,Ee.fromCommitFileStatus)(ye.status)??b.GitFileIndexStatus.Modified,ye.previous_filename,void 0,{additions:ye.additions??0,deletions:ye.deletions??0,changes:ye.changes??0})),xe=(0,ve.Mh)(U)?void 0:be?.find(ye=>ye.path===U)??new b.GitFileChange(e,U,b.GitFileIndexStatus.Modified,void 0,void 0,H.changedFiles===1?{additions:H.additions??0,deletions:H.deletions??0,changes:0}:void 0);Q=new b.GitCommit(this.container,e,H.oid,new b.GitCommitIdentity(X,H.author.email,new Date(H.author.date),H.author.avatarUrl),new b.GitCommitIdentity(k,H.committer.email,new Date(H.committer.date)),H.message.split(`
`,1)[0],H.parents.nodes.map(ye=>ye.oid),H.message,{file:xe,files:be},{changedFiles:H.changedFiles??0,additions:H.additions??0,deletions:H.deletions??0},[]),P.set(H.oid,Q)}}const Z={repoPath:e,commits:P,sha:O,range:void 0,count:P.size,limit:M,hasMore:((m=B.paging)==null?void 0:m.more)??!1,cursor:(S=B.paging)==null?void 0:S.cursor,query:H=>this.getLogForFile(e,t,ee(ne({},d),{limit:H}))};return Z.hasMore&&(Z.more=this.getLogForFileMoreFn(Z,t,d)),Z}catch(E){if(r.state!=null&&d?.range==null&&!d?.reverse){const F=E?.toString()??"";A.Y.debug(g,`Cache replace (with empty promise): '${a}'`);const D={item:Re,errorMessage:F};return r.state.setLog(a,D),Re}return}}getLogForFileMoreFn(e,t,r){return async a=>{const g=a!=null&&typeof a=="object"?a.until:void 0;let d=typeof a=="number"?a:void 0;if(g&&(0,Se.G)(e.commits.values(),M=>M.ref===g))return e;d=this.getPagingLimit(d);const v=await this.getLogForFile(e.repoPath,t,ee(ne({},r),{limit:g==null?d:0,cursor:e.cursor}));if(v==null)return ee(ne({},e),{hasMore:!1});const m=new Map([...e.commits,...v.commits]),S={repoPath:e.repoPath,commits:m,sha:e.sha,range:e.range,count:m.size,limit:g==null?(e.limit??0)+d:void 0,hasMore:g==null?v.hasMore:!0,cursor:v.cursor,query:e.query};return S.more=this.getLogForFileMoreFn(S,t,r),S}}async getMergeBase(e,t,r,a){}async getMergeStatus(e){}async getRebaseStatus(e){}async getNextComparisonUris(e,t,r,a=0){if(!r)return;const g=A.Y.getCorrelationContext();try{const d=await this.ensureRepositoryContext(e);if(d==null)return;const{metadata:v,github:m,remotehub:S,session:M}=d,E=this.getRelativePath(t,S.getProviderRootUri(t)),F=(await v.getRevision()).revision;r==="HEAD"&&(r=F);const D=await m.getNextCommitRefs(M.accessToken,v.repo.owner,v.repo.name,F,E,r);return{current:a===0?ue.YY.fromFile(E,e,r):new ue.YY(await this.getBestRevisionUri(e,E,D[a-1])),next:new ue.YY(await this.getBestRevisionUri(e,E,D[a]))}}catch(d){throw A.Y.error(d,g),d}}async getPreviousComparisonUris(e,t,r,a=0,g=!1){var d,v;if(r===b.GitRevision.deletedOrMissing)return;const m=A.Y.getCorrelationContext();r===b.GitRevision.uncommitted&&(r=void 0);try{const S=await this.ensureRepositoryContext(e);if(S==null)return;const{metadata:M,github:E,remotehub:F,session:D}=S,N=this.getRelativePath(t,F.getProviderRootUri(t)),J=r!=null?1:0,x=await E.getCommitRefs(D.accessToken,M.repo.owner,M.repo.name,!r||r==="HEAD"?(await M.getRevision()).revision:r,{path:N,first:J+a+1});if(x==null)return;const U=a===0?ue.YY.fromFile(N,e,r):new ue.YY(await this.getBestRevisionUri(e,N,((d=x.values[J+a-1])==null?void 0:d.oid)??b.GitRevision.deletedOrMissing));return U==null||U.sha===b.GitRevision.deletedOrMissing?void 0:{current:U,previous:new ue.YY(await this.getBestRevisionUri(e,N,((v=x.values[J+a])==null?void 0:v.oid)??b.GitRevision.deletedOrMissing))}}catch(S){throw A.Y.error(S,m),S}}async getPreviousComparisonUrisForLine(e,t,r,a,g=0){var d,v;if(a===b.GitRevision.deletedOrMissing)return;const m=A.Y.getCorrelationContext();try{const S=await this.ensureRepositoryContext(e);if(S==null)return;const{remotehub:M}=S;let E=this.getRelativePath(t,M.getProviderRootUri(t)),F=ue.YY.fromFile(E,e,a),D=r,N,J=r,x=r;for(let U=0;U<Math.max(0,g)+2;U++){const O=await this.getBlameForLine(N??F,x,void 0,{forceSingleLine:!0});if(O==null)break;a=O.commit.sha,E=((d=O.commit.file)==null?void 0:d.path)??((v=O.commit.file)==null?void 0:v.originalPath)??E,x=O.line.originalLine-1;const B=ue.YY.fromFile(E,e,a);N==null?(N=B,J=x):(F=N,D=J,N=B,J=x)}return F==null?void 0:{current:F,previous:N,line:(D??r)+1}}catch(S){throw A.Y.error(S,m),S}}async getIncomingActivity(e,t){}async getRemotes(e,t){if(e==null)return[];const r=t?.providers??he.c.loadProviders(W.DN.get("remotes",null)),a=T.Uri.parse(e,!0),[,g,d]=a.path.split("/",3),v=`https://github.com/${g}/${d}.git`,m="github.com",S=`${g}/${d}`;return[new b.GitRemote(e,`${m}/${S}`,"origin","https",m,S,he.c.factory(r)(v,m,S),[{type:b.GitRemoteType.Fetch,url:v},{type:b.GitRemoteType.Push,url:v}])]}async getRevisionContent(e,t,r){const a=r?this.createProviderUri(e,r,t):this.createVirtualUri(e,r,t);return T.workspace.fs.readFile(a)}async getStash(e){}async getStatusForFile(e,t){}async getStatusForFiles(e,t){}async getStatusForRepo(e){}async getTags(e,t){if(e==null)return Fe;const r=A.Y.getCorrelationContext();let a=t?.cursor?void 0:this._tagsCache.get(e);if(a==null){async function d(){var v,m,S;try{const{metadata:M,github:E,session:F}=await this.ensureRepositoryContext(e),D=[];let N=t?.cursor;const J=N==null;for(;;){const x=await E.getTags(F.accessToken,M.repo.owner,M.repo.name,{cursor:N});for(const U of x.values)D.push(new b.GitTag(e,U.name,U.target.oid,U.target.message??"",new Date(U.target.authoredDate??((v=U.target.tagger)==null?void 0:v.date)),new Date(U.target.committedDate??((m=U.target.tagger)==null?void 0:m.date))));if(!((S=x.paging)!=null&&S.more)||!J)return ee(ne({},x),{values:D});N=x.paging.cursor}}catch(M){return A.Y.error(M,r),this._tagsCache.delete(e),Fe}}y(d,"load"),a=d.call(this),t?.cursor==null&&this._tagsCache.set(e,a)}let g=await a;return t?.filter!=null&&(g=ee(ne({},g),{values:g.values.filter(t.filter)})),t?.sort!=null&&b.GitTag.sort(g.values,typeof t.sort=="boolean"?void 0:t.sort),g}async getTreeEntryForRevision(e,t,r){if(e==null||!t)return;if(r==="HEAD"){const d=await this.ensureRepositoryContext(e);if(d==null)return;const v=await d.metadata.getRevision();r=v?.revision}const a=r?this.createProviderUri(e,r,t):this.createVirtualUri(e,r,t),g=await T.workspace.fs.stat(a);if(g!=null)return{path:this.getRelativePath(a,e),commitSha:r,size:g.size,type:g.type===T.FileType.Directory?"tree":"blob"}}async getTreeForRevision(e,t){if(e==null)return[];if(t==="HEAD"){const d=await this.ensureRepositoryContext(e);if(d==null)return[];const v=await d.metadata.getRevision();t=v?.revision}const r=t?this.createProviderUri(e,t):this.createVirtualUri(e,t),a=await T.workspace.fs.readDirectory(r);if(a==null)return[];const g=[];for(const[d,v]of a){const m=this.getAbsoluteUri(d,r);g.push({path:this.getRelativePath(d,m),commitSha:t,size:0,type:v===T.FileType.Directory?"tree":"blob"})}return[]}async hasBranchOrTag(e,t){var r,a;const[{values:g},{values:d}]=await Promise.all([this.getBranches(e,{filter:(r=t?.filter)==null?void 0:r.branches,sort:!1}),this.getTags(e,{filter:(a=t?.filter)==null?void 0:a.tags,sort:!1})]);return g.length!==0||d.length!==0}async hasCommitBeenPushed(e,t){return!0}isTrackable(e){return this.supportedSchemes.has(e.scheme)}isTracked(e){return Promise.resolve(this.isTrackable(e)&&this.container.git.getRepository(e)!=null)}async getDiffTool(e){}async openDiffTool(e,t,r){}async openDirectoryCompare(e,t,r,a){}async resolveReference(e,t,r,a){if(!t||t===b.GitRevision.deletedOrMissing||r==null&&b.GitRevision.isSha(t)||r!=null&&b.GitRevision.isUncommitted(t))return t;let g;if(r!=null)g=this.getRelativePath(r,e);else if(!b.GitRevision.isShaLike(t)||t.endsWith("^3"))return t;const d=await this.ensureRepositoryContext(e);if(d==null)return t;const{metadata:v,github:m,session:S}=d,M=await m.resolveReference(S.accessToken,v.repo.owner,v.repo.name,t,g);return M??(g?b.GitRevision.deletedOrMissing:t)}async validateBranchOrTagName(e,t){return qe.test(e)}async validateReference(e,t){return!0}async stageFile(e,t){}async stageDirectory(e,t){}async unStageFile(e,t){}async unStageDirectory(e,t){}async stashApply(e,t,r){}async stashDelete(e,t,r){}async stashSave(e,t,r,a){}async ensureRepositoryContext(e,t){let r=T.Uri.parse(e,!0);if(!/^github\+?/.test(r.authority))throw new L.kX(e,L.sh.NotAGitHubRepository);if(!t){const m=this.container.git.getRepository(r);if(m==null)throw new L.kX(e,L.sh.NotAGitHubRepository);r=m.uri}let a=this._remotehub;if(a==null)try{a=await this.ensureRemoteHubApi()}catch(m){throw m instanceof L.R5,new L.kX(e,L.sh.RemoteHubApiNotFound,m)}const g=await a?.getMetadata(r);if(g?.provider.id!=="github")throw new L.kX(e,L.sh.NotAGitHubRepository);let d,v;try{[d,v]=await Promise.all([this.ensureGitHub(),this.ensureSession()])}catch(m){throw m instanceof L._7?new L.kX(e,m.reason===L.Jx.UserDidNotConsent?L.sh.GitHubAuthenticationDenied:L.sh.GitHubAuthenticationNotFound,m):new L.kX(e)}if(d==null)throw new L.kX(e);return{github:d,metadata:g,remotehub:a,session:v}}async ensureGitHub(){if(this._github==null){const e=await this.container.github;e!=null&&this._disposables.push(e.onDidReauthenticate(()=>{this._sessionPromise=void 0,this.ensureSession(!0)})),this._github=e}return this._github}async ensureRemoteHubApi(e){if(this._remotehubPromise==null&&(this._remotehubPromise=Ge(),this._remotehubPromise.then(t=>this._remotehub=t,()=>this._remotehub=void 0)),!e)return this._remotehubPromise;try{return await this._remotehubPromise}catch{return}}async ensureSession(e=!1){if(this._sessionPromise==null){async function t(){try{return e?await T.authentication.getSession("github",Ye,{forceNewSession:!0}):await T.authentication.getSession("github",Ye,{createIfNone:!0})}catch(r){throw r instanceof Error&&r.message.includes("User did not consent")?new L._7("github",L.Jx.UserDidNotConsent):(A.Y.error(r),new L._7("github",void 0,r))}}y(t,"getSession"),this._sessionPromise=t()}return this._sessionPromise}createVirtualUri(e,t,r){let a;if(typeof t=="string")t&&(b.GitRevision.isSha(t)?a={v:1,ref:{id:t,type:2}}:a={v:1,ref:{id:t,type:4}});else switch(t?.refType){case"revision":case"stash":a={v:1,ref:{id:t.ref,type:2}};break;case"branch":case"tag":a={v:1,ref:{id:t.name,type:4}};break}if(typeof e=="string"&&(e=T.Uri.parse(e,!0)),r){let g=e.path;g.endsWith("/")&&(g=g.slice(0,-1)),r=this.getRelativePath(r,e),r=`${g}/${r.startsWith("/")?r.slice(0,-1):r}`}return e.with({scheme:V.sN.Virtual,authority:Je("github",a),path:r??e.path})}createProviderUri(e,t,r){const a=this.createVirtualUri(e,t,r);return this._remotehub==null?a.scheme!==V.sN.Virtual?a:a.with({scheme:V.sN.GitHub}):this._remotehub.getProviderUri(a)}getPagingLimit(e){return e=Math.min(100,e??this.container.config.advanced.maxListItems??100),e===0&&(e=100),e}async resolveReferenceCore(e,t,r){var a,g;if(r==null||r==="HEAD")return(await t.getRevision()).revision;if(b.GitRevision.isSha(r))return r;if(b.GitRevision.isRange(r))return;const[d,v]=await Promise.allSettled([this.getBranches(e,{filter:m=>m.name===r}),this.getTags(e,{filter:m=>m.name===r})]);return r=(d.status==="fulfilled"?(a=d.value.values[0])==null?void 0:a.sha:void 0)??(v.status==="fulfilled"?(g=v.value.values[0])==null?void 0:g.sha:void 0),r==null,r}}y(w,"GitHubGitProvider"),R([(0,$.cM)()],w.prototype,"getBestRevisionUri",1),R([(0,$.cM)()],w.prototype,"getWorkingUri",1),R([(0,$.cM)()],w.prototype,"addRemote",1),R([(0,$.cM)()],w.prototype,"pruneRemote",1),R([(0,$.cM)()],w.prototype,"applyChangesToWorkingFile",1),R([(0,$.cM)()],w.prototype,"branchContainsCommit",1),R([(0,$.cM)()],w.prototype,"checkout",1),R([(0,$.cM)()],w.prototype,"resetCaches",1),R([(0,$.cM)({args:{1:G=>G.length}})],w.prototype,"excludeIgnoredUris",1),R([(0,$.cM)()],w.prototype,"fetch",1),R([(0,fe.H)(),(0,$.fF)()],w.prototype,"findRepositoryUri",1),R([(0,$.cM)({args:{1:G=>G.join(",")}})],w.prototype,"getAheadBehindCommitCount",1),R([(0,fe.H)(),(0,$.cM)()],w.prototype,"getBlame",1),R([(0,$.cM)({args:{1:"<contents>"}})],w.prototype,"getBlameContents",1),R([(0,fe.H)(),(0,$.cM)()],w.prototype,"getBlameForLine",1),R([(0,$.cM)({args:{2:"<contents>"}})],w.prototype,"getBlameForLineContents",1),R([(0,$.cM)()],w.prototype,"getBlameForRange",1),R([(0,$.cM)({args:{2:"<contents>"}})],w.prototype,"getBlameForRangeContents",1),R([(0,$.cM)({args:{0:"<blame>"}})],w.prototype,"getBlameRange",1),R([(0,$.cM)()],w.prototype,"getBranch",1),R([(0,$.cM)({args:{1:!1}})],w.prototype,"getBranches",1),R([(0,$.cM)()],w.prototype,"getChangedFilesCount",1),R([(0,$.cM)()],w.prototype,"getCommit",1),R([(0,$.cM)()],w.prototype,"getCommitBranches",1),R([(0,$.cM)()],w.prototype,"getCommitCount",1),R([(0,$.cM)()],w.prototype,"getCommitForFile",1),R([(0,$.cM)()],w.prototype,"getOldestUnpushedRefForFile",1),R([(0,$.cM)()],w.prototype,"getContributors",1),R([(0,fe.H)(),(0,$.cM)()],w.prototype,"getCurrentUser",1),R([(0,$.cM)()],w.prototype,"getDefaultBranchName",1),R([(0,$.cM)()],w.prototype,"getDiffForFile",1),R([(0,$.cM)({args:{1:G=>"<contents>"}})],w.prototype,"getDiffForFileContents",1),R([(0,$.cM)()],w.prototype,"getDiffForLine",1),R([(0,$.cM)()],w.prototype,"getDiffStatus",1),R([(0,$.cM)()],w.prototype,"getFileStatusForCommit",1),R([(0,$.cM)()],w.prototype,"getLog",1),R([(0,$.cM)()],w.prototype,"getLogRefsOnly",1),R([(0,$.cM)()],w.prototype,"getLogForSearch",1),R([(0,$.cM)()],w.prototype,"getLogForFile",1),R([(0,$.cM)()],w.prototype,"getMergeBase",1),R([(0,$.cM)()],w.prototype,"getMergeStatus",1),R([(0,$.cM)()],w.prototype,"getRebaseStatus",1),R([(0,$.cM)()],w.prototype,"getNextComparisonUris",1),R([(0,$.cM)()],w.prototype,"getPreviousComparisonUris",1),R([(0,$.cM)()],w.prototype,"getPreviousComparisonUrisForLine",1),R([(0,$.cM)()],w.prototype,"getIncomingActivity",1),R([(0,$.cM)({args:{1:!1}})],w.prototype,"getRemotes",1),R([(0,$.cM)()],w.prototype,"getRevisionContent",1),R([(0,$.cM)()],w.prototype,"getStash",1),R([(0,$.cM)()],w.prototype,"getStatusForFile",1),R([(0,$.cM)()],w.prototype,"getStatusForFiles",1),R([(0,$.cM)()],w.prototype,"getStatusForRepo",1),R([(0,$.cM)({args:{1:!1}})],w.prototype,"getTags",1),R([(0,$.cM)()],w.prototype,"getTreeEntryForRevision",1),R([(0,$.cM)()],w.prototype,"getTreeForRevision",1),R([(0,$.cM)()],w.prototype,"hasBranchOrTag",1),R([(0,$.cM)()],w.prototype,"hasCommitBeenPushed",1),R([(0,$.cM)()],w.prototype,"getDiffTool",1),R([(0,$.cM)()],w.prototype,"openDiffTool",1),R([(0,$.cM)()],w.prototype,"openDirectoryCompare",1),R([(0,$.cM)()],w.prototype,"resolveReference",1),R([(0,$.cM)()],w.prototype,"validateBranchOrTagName",1),R([(0,$.cM)()],w.prototype,"validateReference",1),R([(0,$.cM)()],w.prototype,"stageFile",1),R([(0,$.cM)()],w.prototype,"stageDirectory",1),R([(0,$.cM)()],w.prototype,"unStageFile",1),R([(0,$.cM)()],w.prototype,"unStageDirectory",1),R([(0,$.cM)()],w.prototype,"stashApply",1),R([(0,$.cM)()],w.prototype,"stashDelete",1),R([(0,$.cM)({args:{2:G=>G?.length}})],w.prototype,"stashSave",1),R([(0,fe.H)()],w.prototype,"ensureRepositoryContext",1),R([(0,fe.H)()],w.prototype,"ensureGitHub",1);function Je(G,e){return`${G}${e!=null?`+${(0,ie.e)(JSON.stringify(e))}`:""}`}y(Je,"encodeAuthority")},778:(ae,le,_)=>{var T=_(2479);ae.exports=T(ie),ae.exports.strict=T(W),ie.proto=ie(function(){Object.defineProperty(Function.prototype,"once",{value:function(){return ie(this)},configurable:!0}),Object.defineProperty(Function.prototype,"onceStrict",{value:function(){return W(this)},configurable:!0})});function ie(V){var z=y(function(){return z.called?z.value:(z.called=!0,z.value=V.apply(this,arguments))},"f");return z.called=!1,z}y(ie,"once");function W(V){var z=y(function(){if(z.called)throw new Error(z.onceError);return z.called=!0,z.value=V.apply(this,arguments)},"f"),L=V.name||"Function wrapped with `once`";return z.onceError=L+" shouldn't be called more than once",z.called=!1,z}y(W,"onceStrict")},2479:ae=>{ae.exports=le;function le(_,T){if(_&&T)return le(_)(T);if(typeof _!="function")throw new TypeError("need wrapper function");return Object.keys(_).forEach(function(W){ie[W]=_[W]}),ie;function ie(){for(var W=new Array(arguments.length),V=0;V<W.length;V++)W[V]=arguments[V];var z=_.apply(this,W),L=W[W.length-1];return typeof z=="function"&&z!==L&&Object.keys(L).forEach(function(de){z[de]=L[de]}),z}y(ie,"wrapper")}y(le,"wrappy")}};

//# sourceMappingURL=feature-github.js.map