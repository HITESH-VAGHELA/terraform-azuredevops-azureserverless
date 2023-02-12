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
const httpTrigger = function (context, req) {
    return __awaiter(this, void 0, void 0, function* () {
        context.log.info('Create todo item started.');
        const newItem = req.body;
        if (newItem && newItem.title && newItem.description) {
            const todoItem = {
                id: (0, Utils_1.getGuid)(),
                title: newItem.title,
                description: newItem.description
            };
            const todoItemRecord = Object.assign({ userId: (0, Utils_1.getUserId)() }, todoItem);
            context.bindings.todoItemRecord = todoItemRecord;
            context.res = {
                status: 201,
                body: todoItem
            };
        }
        else {
            context.res = {
                status: 400
            };
            context.log.error('Create todo item invalid input.', context.invocationId, JSON.stringify(newItem));
        }
        context.log.info('Create todo item completed.');
        context.done();
    });
};
exports.default = httpTrigger;
//# sourceMappingURL=index.js.map