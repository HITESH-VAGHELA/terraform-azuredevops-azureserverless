"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getGuid = exports.getUserId = void 0;
const uuid_1 = require("uuid");
function getUserId() {
    return 'dummy-userId';
}
exports.getUserId = getUserId;
function getGuid() {
    return (0, uuid_1.v4)();
}
exports.getGuid = getGuid;
//# sourceMappingURL=Utils.js.map