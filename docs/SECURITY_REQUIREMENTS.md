# Security Requirements

## MVP security posture

This planning MVP does not claim HIPAA compliance and must not store real health information. The requirements below are planning requirements for future implementation review.

## Immediate constraints

- Use synthetic data only.
- No real portal connections.
- No real OAuth client IDs, client secrets, access tokens, refresh tokens, or API keys.
- No production database.
- No deployment.
- No logging of real health data.
- No password collection for MyChart, Epic, Apple Health, Health Connect, or other portals.

## Future security requirements to design before production

- Encrypt data in transit.
- Encrypt sensitive data at rest.
- Use strong authentication for user accounts.
- Use secure password hashing if passwords are implemented.
- Store OAuth tokens only in a dedicated secrets/token storage pattern.
- Minimize token scopes.
- Separate raw records, normalized history, and current profile permissions.
- Maintain audit events for changes to medical information.
- Maintain access logs for sensitive record views.
- Implement data deletion/export policy.
- Implement session timeout and device/session management.
- Restrict admin access.
- Document incident response.
- Review backups, retention, and restore behavior.
- Review vendor agreements and hosting responsibilities.

## HIPAA-related planning notes

The HHS HIPAA Security Rule describes administrative, physical, and technical safeguards for electronic protected health information. Whether this product is directly subject to HIPAA depends on facts that require legal analysis, including whether the company is a covered entity, business associate, or direct-to-consumer app outside HIPAA but subject to other privacy laws.

Reference:

- HHS HIPAA Security Rule: https://www.hhs.gov/hipaa/for-professionals/security/index.html

## Consumer health privacy planning notes

Depending on the product model, integrations, data sharing, and breach definitions, consumer health privacy and breach notification obligations may apply even when HIPAA does not.

References:

- FTC Health Breach Notification Rule: https://www.ftc.gov/legal-library/browse/rules/health-breach-notification-rule
- FTC health apps guidance: https://www.ftc.gov/business-guidance/privacy-security/health-privacy

## Source sign-in requirement

The product must clearly state: users sign in through the source; we never collect portal passwords. Future source integrations should use the source's patient authorization flow rather than password scraping.
