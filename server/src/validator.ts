export class Validator {
    errors: string[];

    constructor() {
        this.errors = [];
    }

    assertExists(name: string, element: any): void {
        if (!element) {
            this.errors.push(`${name} must be given.`);
        }
    }

    assertLength(name: string, string: string, length: number): void {
        if (!string || string.length < length) {
            this.errors.push(
                `${name} must be at least be ${length} characters long.`,
            );
        }
    }

    assertGreaterThan(
        name: string,
        value: number,
        greaterThanAmount: number,
    ): void {
        if (!value || value <= greaterThanAmount) {
            this.errors.push(
                `${name} must be greater than ${greaterThanAmount}.`,
            );
        }
    }

    hasErrors(): boolean {
        return this.errors.length > 0;
    }

    getErrors(): string {
        return Validator.getErrorsString(this.errors);
    }

    static getErrorsString(errors: string[]): string {
        return JSON.stringify({ errors: errors });
    }
}
