"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const Utils_1 = require("../Common/Utils");
const todo_item_repository_1 = require("../DataAccess/todo-item-repository");
const httpTrigger = function (context, req) {
    return __awaiter(this, void 0, void 0, function* () {
        context.log.info('Delete todo item started.');
        const id = context.bindingData.id;
        const userId = (0, Utils_1.getUserId)();
        try {
            yield (0, todo_item_repository_1.deleteTodoItem)(id, userId);
            context.res = {
                status: 204
            };
        }
        catch (error) {
            if (error.message.includes("Entity with the specified id does not exist in the system")) {
                context.res = {
                    status: 404
                };
            }
            else {
                throw error;
            }
        }
        context.log.info('Delete todo item completed.');
        context.done();
    });
};
exports.default = httpTrigger;
//# sourceMappingURL=index.js.map