# Xperience 2025 - Get Ticket Status

A Genesys Cloud function that retrieves ticket status information from TicketFlow via HTTP API calls. This project is built with TypeScript and can be deployed to AWS Lambda or Genesys Cloud.

## Project Overview

This function integrates with TicketFlow to fetch ticket details including:
- Ticket number
- Status
- Priority
- Change date
- Notes

## Prerequisites

Before setting up this project locally, ensure you have the following installed:

- **Node.js** (v20.x or higher) - [Download here](https://nodejs.org/)
- **npm** (comes with Node.js)
- **TypeScript** (will be installed via npm)
- **Git** - [Download here](https://git-scm.com/)

## Local Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd xperience2025_genesyscloud_functions
```

### 2. Install Dependencies

```bash
npm install
```

This will install all required dependencies including:
- `axios` - HTTP client for API calls
- `@types/aws-lambda` - TypeScript definitions for AWS Lambda
- `typescript` - TypeScript compiler
- Other development dependencies

### 3. Build the Project

```bash
npm run build
```

This command will:
- Clean the `dist/` directory
- Compile TypeScript files to JavaScript
- Output compiled files to `./dist/`

### 4. Create Deployment Package

```bash
npm run zip
```

This creates a deployment package (`xp2025_get_ticket_status.zip`) containing:
- Compiled JavaScript files from `dist/`
- Production dependencies from `node_modules/`

## Development

### Project Structure

```
├── src/
│   ├── index.ts              # Main function handler
├── tofu/
│   └── main.tf               # Terraform configuration for Genesys Cloud
├── dist/                     # Compiled JavaScript output
├── package.json              # Dependencies and scripts
├── tsconfig.json             # TypeScript configuration
└── serverless.yml            # Serverless Framework configuration
```

### Available Scripts

- `npm run compile` - Compile TypeScript to JavaScript
- `npm run build` - Clean and compile the project
- `npm run zip` - Create deployment package
- `npm run zipnodev` - Create production deployment package (excludes dev dependencies)

### Local Testing

To test the function locally, you can:

1. **Compile the code:**
   ```bash
   npm run compile
   ```

2. **Test with sample data:**
   Create a test file or use the compiled output in `dist/` directory.

3. **Environment Variables:**
   The function expects a `ticket_number` parameter in the event object.

## Deployment

### Option 1: Genesys Cloud (Recommended)

This project is configured for Genesys Cloud deployment using Terraform:

1. **Navigate to the Terraform directory:**
   ```bash
   cd tofu
   ```

2. **Initialize Terraform:**
   ```bash
   terraform init
   ```

3. **Deploy to Genesys Cloud:**
   ```bash
   terraform plan
   terraform apply
   ```

The Terraform configuration will:
- Create a Genesys Cloud integration
- Deploy the function with the specified configuration
- Set up data actions for ticket status retrieval

### Option 2: AWS Lambda (Serverless Framework)

If deploying to AWS Lambda:

1. **Install Serverless Framework globally:**
   ```bash
   npm install -g serverless
   ```

2. **Deploy to AWS:**
   ```bash
   serverless deploy
   ```

## Configuration

### TypeScript Configuration (`tsconfig.json`)

- **Target**: ES2020
- **Module System**: CommonJS
- **Strict Mode**: Enabled
- **Output Directory**: `./dist`
- **Source Maps**: Enabled

### Function Configuration

- **Runtime**: Node.js 20.x
- **Timeout**: 15 seconds
- **Memory**: 512 MB (AWS Lambda)
- **Handler**: `dist/index.handler`

## API Integration

The function integrates with TicketFlow via HTTP API calls:

- **Endpoint**: `https://ticketflow.ngrok.io/rest/ticket/{ticket_number}`
- **Method**: GET
- **Response Format**: JSON with ticket details

### Input Schema

```json
{
  "ticket_number": "string"
}
```

### Output Schema

```json
{
  "ticket_number": "string",
  "status": "string",
  "priority": "string",
  "changed": "string",
  "notes": "string"
}
```

## Troubleshooting

### Common Issues

1. **TypeScript Compilation Errors:**
   - Ensure all dependencies are installed: `npm install`
   - Check TypeScript version compatibility
   - Verify `tsconfig.json` settings

2. **Build Failures:**
   - Clean the `dist/` directory manually if needed
   - Check for syntax errors in TypeScript files

3. **Deployment Issues:**
   - Verify the deployment package was created successfully
   - Check Terraform/Serverless configuration
   - Ensure proper credentials and permissions

### Logs and Debugging

- The function includes comprehensive logging
- Check CloudWatch logs (AWS) or Genesys Cloud logs for runtime issues
- Use `console.log` statements for debugging

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

[Add your license information here]

## Support

For issues and questions:
- Check the troubleshooting section above
- Review Genesys Cloud documentation
- Contact your development team
